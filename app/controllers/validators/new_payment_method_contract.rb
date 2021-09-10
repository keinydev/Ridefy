require_relative './application_contract.rb'

class NewPaymentMethodContract < ApplicationContract

	params do
    required(:email).filled(:string)
    required(:method_type).filled(:string)
    required(:token).filled(:string)
    required(:acceptance_token).filled(:string)
    required(:accepted_contract).filled(:bool)
  end

  rule(:email).validate(:email_format)

  rule(:method_type) do
    key.failure('This app only accept CARD or NEQUI') if value != 'CARD' and value != 'NEQUI'
  end

  rule(:accepted_contract) do
    key.failure('The user must accept the contract in order to comply Colombian regulation and Habeas data') if value == false
  end
end
