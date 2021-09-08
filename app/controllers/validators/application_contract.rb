require 'dry-validation'

ContactSchema = Dry::Schema.Params do
  required(:email).filled(:string) 
  required(:phone).filled(:string)
end

class ApplicationContract < Dry::Validation::Contract
  register_macro(:email_format) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('not a valid email format')
    end
  end
end
