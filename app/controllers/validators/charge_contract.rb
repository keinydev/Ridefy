require_relative './application_contract.rb'

class ChargeContract < ApplicationContract

  params do
    required(:email).filled(:string)
    required(:payment_method_id).value(:integer)
    required(:acceptance_token).filled(:string)
  end

  rule(:email).validate(:email_format)
end
