require_relative './application_contract.rb'
require 'dry-types'

module Types
  include Dry::Types()
  Location = Types::Hash.schema(longitude: Types::Float, latitude: Types::Float)
end

class FinishTripContract < ApplicationContract
  params do
    required(:id).value(:integer)
    required(:end_location).filled(Types::Location)
    required(:acceptance_token).filled(:string)
  end
end
