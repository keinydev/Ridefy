require 'faker'

FactoryBot.define do
  factory :car do
    license_plate    { Faker::Vehicle.unique.license_plate }
    car_type         { Faker::Vehicle.car_type }
    active           { true }
    driver
  end
end
