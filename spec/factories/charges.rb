require 'faker'

FactoryBot.define do
  factory :charge do
    total           { Faker::Commerce.price }
    payment_method
    trip
  end
end
