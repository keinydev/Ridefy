require 'faker'
require_relative '../app/models/rider'
require_relative '../app/models/driver'
require_relative '../app/models/car'

10.times do |i|
  Rider.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone: Faker::Base.numerify('##########'), email: "rider_#{i}@example.com")
end

20.times do |i|
  driver = Driver.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, phone: Faker::Base.numerify('##########'), email: "driver_#{i}@example.com", driving_license_number: Faker::DrivingLicence.unique.usa_driving_licence, expiring_date: Faker::Business.credit_card_expiry_date, working: true)
  driver.cars.create(license_plate: Faker::Vehicle.unique.license_plate, car_type: Faker::Vehicle.car_type)
end
