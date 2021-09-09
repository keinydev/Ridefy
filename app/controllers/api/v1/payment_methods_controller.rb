require "./lib/request_helper"
require './app/controllers/validators/new_payment_method_contract.rb'
require './app/models/payment_method'
require './app/models/rider'

module Api
  module V1
		class PaymentMethodsController

		  def initialize(data)
		  	@data = data
		  	@contract_validation = NewPaymentMethodContract.new.call(@data)
		  end

		  def run
				return api_response("error", @contract_validation.errors.to_h) if validation
				return api_response("error", { email: "Email not found" })     if rider.nil?
				
				payment_method_request
		  end

      def payment_method_request
      	response = RequestHelpers::Wompi::post("/payment_sources", body_request)
		    res_body = RequestHelpers::json_response(response.body)

		    if response.code == 200
		    	@data.merge(source_id: res_body["data"]["id"])
		    	create_payment_method
		    else
		    	api_response("error", res_body["error"]["messages"])
		    end  	
      end

		  def create_payment_method
		    @payment_method = PaymentMethod.new(params)
		    # print(@payment_method)
		    if @payment_method.save
		      api_response("payment_method", @payment_method)
		    else
		      api_response("error", @payment_method.errors)
		    end
		  end      

      private 

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

      def params
      	{ method_type: @data["method_type"], token: @data["token"], source_id: @data["source_id"], rider_id: rider.id }
      end

		  def api_response(status, message)
		  	{ "#{status}": message }.to_json
		  end

		  def validation
		  	@contract_validation.errors.to_h.length > 0
		  end      
		end
	end
end
