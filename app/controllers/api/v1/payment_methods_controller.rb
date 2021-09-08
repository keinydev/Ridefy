require './app/controllers/validators/new_payment_method_contract.rb'

module Api
  module V1
		class PaymentMethodsController
		  require './app/models/payment_method'

		  def run(data)
				validate = NewPaymentMethodContract.new.call(data)
				return { message: validate.errors.to_h }.to_json if validate.errors.to_h.length > 0
 				create(data)
		  end

		  def create
		  	print(data)
		  end
		end
	end
end
