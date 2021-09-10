require './app/controllers/validators/request_trip_contract.rb'

module Api
	module V1
		class RequestTripsController

			def initialize(data)
				@errors = {}
				@data = data
				@contract_validation = RequestTripContract.new.call(@data)
			end

			def run
				return { errors: @contract_validation.errors.to_h }.to_json                                 if validation
				return { errors: { driver: "At this moment, drivers are not available" }}.to_json           if driver.nil?
				return { errors: { email: "Email not found" }}.to_json                                      if rider.nil?
				return { errors: { payment_method: "You must register the payment method first" }}.to_json  if rider_authorized.nil?

				create_trip
			end

			def create_trip
				@trip = Trip.new(params)
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
			
			def rider_authorized
				@rider_authorized = Rider.rider_authorized(@data["email"]).first
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
