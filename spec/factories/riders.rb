require 'faker'

FactoryBot.define do
  factory :rider do
    first_name   { Faker::Name.first_name }
    last_name    { Faker::Name.last_name }
    phone        { Faker::Base.numerify('##########') }
    email        { Faker::Internet.unique.email }
  end
end
