# models/driver.rb

class Driver < ActiveRecord::Base
  validates :first_name, :last_name, :phone, :email, :driving_license_number, :expiring_date, presence: true

  has_many :trips
  has_many :cars

  scope :find_available, -> () do
    joins(:cars).where("drivers.working = true AND cars.active = true")
  end
end
