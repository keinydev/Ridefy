require 'dry-types'
require_relative './application_contract.rb'

module Types
  include Dry::Types()
  Location = Types::Hash.schema(longitude: Types::Float, latitude: Types::Float)
end

class NewRequestTripContract < ApplicationContract

	params do
    required(:email).filled(:string)
    required(:start_location).filled(Types::Location)
    required(:end_location).filled(Types::Location)
  end

  rule(:email).validate(:email_format)
end
