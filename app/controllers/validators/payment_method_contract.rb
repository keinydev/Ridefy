require_relative './application_contract.rb'

class PaymentMethodContract < ApplicationContract

	params do
		required(:email).filled(:string)
		required(:method_type).filled(:string)
		required(:token).filled(:string)
		required(:acceptance_token).filled(:string)
	end

  rule(:email).validate(:email_format)

  rule(:method_type) do
    key.failure('This app only accept CARD or NEQUI') if value != 'CARD' and value != 'NEQUI'
  end
end
