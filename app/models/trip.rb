# models/trip.rb

class Trip < ActiveRecord::Base
  validates :start_location, :end_location, :start_time, presence: true

  belongs_to :rider
  belongs_to :driver
  belongs_to :car
end
