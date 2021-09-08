# models/car.rb

class Car < ActiveRecord::Base
  validates :license_plate, :car_type, presence: true

  belongs_to :driver
end
