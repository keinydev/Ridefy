require 'geocoder'
require 'time_difference'

module Utils
	extend self

	def calculate_minutes(start_time, end_time)
	  TimeDifference.between(start_time, end_time).in_minutes
	end

  def distance_between(start_location, end_location)
    Geocoder::Calculations.distance_between(start_location, end_location, units: :km)
  end
end
