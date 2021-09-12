require './app/controllers/validators/payment_method_contract.rb'

module Api
  module V1
		class PaymentMethodsController

		  def initialize(data)
		  	@data = data
		  	@contract_validation = PaymentMethodContract.new.call(@data)
		  end

		  def run
				return { errors: @contract_validation.errors.to_h }.to_json  if validation
				return { errors: { email: "Email not found" }}.to_json       if rider.nil?
				
				payment_method_request
		  end

      def payment_method_request
      	response = RequestHelpers::Wompi::post("/payment_sources", body_request)
		    res_body = RequestHelpers::json_response(response.body)

		    if response.status.success?
		    	@data.merge!(source_id: res_body["data"]["id"])

		    	create_payment_method
		    else
		    	{ errors: res_body }.to_json
		    end  	
      end

		  def create_payment_method
		    @payment_method = PaymentMethod.new(params)

		    if @payment_method.save
		    	{ 
		    		data: {
			    		id: @payment_method.id,
			    		method_type: @payment_method.method_type,
			    		source_id: @payment_method.source_id,
			    		rider: {
			    			id: @payment_method.rider.id,
			    			email: @payment_method.rider.email
			    		}
		    		}
		    	}.to_json
		    else
		    	{ errors: @payment_method.errors }.to_json
		    end
		  end      

      private 

      def params
      	@data = @data.transform_keys(&:to_s)
      	{ method_type: @data["method_type"], source_id: @data["source_id"], rider_id: rider.id }
      end
		  
		  def rider
        @rider = Rider.find_by(email: @data["email"])
      end

      def body_request
      	{
      		type: @data["method_type"],
      		token: @data["token"],
      		customer_email: @data["email"],
      		acceptance_token: @data["acceptance_token"]
      	}
      end

		  def validation
		  	@contract_validation.errors.to_h.length > 0
		  end      
		end
	end
end
