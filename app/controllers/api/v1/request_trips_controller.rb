require './app/controllers/validators/new_request_trip_contract.rb'

module Api
  module V1
		class RequestTripsController

		  def initialize(data)
		  	@data = data
		  	@contract_validation = NewRequestTripContract.new.call(@data)
		  end

		  def run
				return { errors: @contract_validation.errors.to_h }.to_json                        if validation
				return { errors: { email: "Email not found" }}.to_json                             if rider.nil?
				return { errors: { driver: "At this moment, drivers are not available" }}.to_json  if driver.nil?
				
				create_trip
		  end

		  def create_trip
		    @trip = Trip.new(params)
		    # print(@payment_method)
		    if @trip.save
		    	{ trip: @trip }.to_json
		    else
		    	{ errors: @trip.errors }.to_json
		    end
		  end      

      private 

      def params
      	{ start_location: @data["start_location"], end_location: @data["end_location"], start_time: Time.now, rider_id: rider.id, driver_id: driver.id, car_id: driver.cars.first.id }
      end
		  
		  def rider
        @rider = Rider.find_by(email: @data["email"])
      end

		  def driver
        @driver = Driver.find_available.last
      end

		  def validation
		  	@contract_validation.errors.to_h.length > 0
		  end      
		end
	end
end
