require_relative './application_contract.rb'

class RequestTripContract < ApplicationContract

  params do
    required(:email).filled(:string)
    required(:start_location).filled(Types::Location)
    required(:end_location).filled(Types::Location)
  end

  rule(:email).validate(:email_format)
end
