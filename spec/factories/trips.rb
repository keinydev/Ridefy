require 'faker'

FactoryBot.define do
  factory :trip do
    start_location    { { latitude: Faker::Address.latitude, longitude: Faker::Address.longitude } }
    end_location      { { latitude: Faker::Address.latitude, longitude: Faker::Address.longitude } }
    start_time        { DateTime.now }
    end_time          { nil }
    rider
    driver
    car
  end
end
