require 'faker'

FactoryBot.define do
  factory :trip do
    start_location    { { latitude: Faker::Address.latitude, longitude: Faker::Address.longitude } }
    end_location      { { latitude: Faker::Address.latitude, longitude: Faker::Address.longitude } }
    start_time        { Faker::Time.between(from: DateTime.now - 1.hour, to: DateTime.now - 30.minutes) }
    end_time          { Faker::Time.between(from: DateTime.now - 31.minutes, to: DateTime.now) }
    rider
    driver
    car
  end
end
