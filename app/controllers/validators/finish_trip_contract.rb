require_relative './application_contract.rb'

class FinishTripContract < ApplicationContract
  params do
    required(:id).value(:integer)
    required(:final_location).filled(Types::Location)
  end
end
