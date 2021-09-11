require 'faker'

FactoryBot.define do
  factory :payment_method do
    method_type  { "CARD" }
    source_id    { "0000" }
    rider
  end
end