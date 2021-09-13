require './app/controllers/validators/charge_contract.rb'

module Api
  module V1
    class ChargesController

      def initialize(data)
        @data = data
        @contract_validation = ChargeContract.new.call(@data)
      end

      def run
        return [400, { errors: @contract_validation.errors.to_h }.to_json]                         if validation
        return [404, { errors: { trip: "Process not found" }}.to_json]                             if charge.nil?
        return [402, { errors: { email: "Payment Method not found" }}.to_json]                     if payment_method.nil?
        return [402, { errors: { email: "This payment is not associated to the rider" }}.to_json]  if no_associated_payment_method
        
        transaction_request
      end

      def transaction_request
        response = RequestHelpers::Wompi::post("/transactions", body_request)
        res_body = RequestHelpers::json_response(response.body)

        if response.status.success?
          @data.merge!(transaction_id: res_body["data"]["id"])

          update_charge
        else
          [422, { errors: res_body }.to_json]
        end   
      end

      def update_charge
        @data = @data.transform_keys(&:to_s)

        if charge.update(transaction_id: @data["transaction_id"], payment_method_id: @data["payment_method_id"])
          {
            data: {
              id: charge.id,
              total: charge.total,
              transaction_id: charge.transaction_id,
              payment_method: {
                id: charge.payment_method.id,
                method_type: charge.payment_method.method_type
              },
              trip: {
                id: charge.trip.id,
                start_location: charge.trip.start_location,
                end_location: charge.trip.end_location,
                start_time: charge.trip.start_time,
                end_time: charge.trip.end_time,   
                driver: {
                  id: charge.trip.driver.id,
                  email: charge.trip.driver.email
                }       
              }
            } 
          }.to_json
        else
          [422, { errors: charge.errors }.to_json]
        end
      end      

      private 

      def charge
        @charge = Charge.find(@data["id"]) rescue nil
      end    

      def payment_method
        @payment_method = PaymentMethod.find(@data["payment_method_id"]) rescue nil
      end           

      def no_associated_payment_method
        !Rider.rider_payment_method(@data["email"], @data["payment_method_id"]).present?
      end      

      def body_request
        {
          amount_in_cents: (charge.total * 100).to_i,
          currency: "COP",
          customer_email: @data["email"],
          payment_method: {
            installments: 2
          },
          reference: "Trip-#{charge.trip.id}",
          payment_source_id: payment_method.source_id
        }
      end

      def validation
        @contract_validation.errors.to_h.length > 0
      end      
    end
  end
end
