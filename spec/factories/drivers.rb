require 'faker'

FactoryBot.define do
  factory :driver do
    first_name               { Faker::Name.first_name }
    last_name                { Faker::Name.last_name }
    phone                    { Faker::Base.numerify('##########') }
    email                    { Faker::Internet.unique.email }
    driving_license_number   { Faker::DrivingLicence.unique.usa_driving_licence }    
    expiring_date            { Faker::Business.credit_card_expiry_date }
    working                  { true }
  end
end
