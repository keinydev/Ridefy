require 'dry-validation'
require 'dry-types'

module Types
  include Dry::Types()
  Location = Types::Hash.schema(longitude: Types::Float, latitude: Types::Float)
end

class ApplicationContract < Dry::Validation::Contract
  register_macro(:email_format) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('not a valid email format')
    end
  end

  register_macro(:payment_method_options) do
  	key.failure('This app only accept CARD or NEQUI') if value != 'CARD' and value != 'NEQUI'
  end  
end
