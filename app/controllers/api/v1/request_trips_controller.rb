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
        return [400, { errors: @contract_validation.errors.to_h }.to_json]                                         if validation
        return [403, { errors: { driver: "At this moment, drivers are not available" }}.to_json]                   if driver.nil?
        return [404, { errors: { email: "Email not found" }}.to_json]                                              if rider.nil?
        return [402, { errors: { payment_method: "You must register the payment method first" }}.to_json]          if rider_authorized
        return [403, { errors: { trip: "You must finish the current trip before requesting a new one" }}.to_json]  if rider_ongoing

        create_trip
      end

      def create_trip
        @trip = Trip.new(params)
        if @trip.save
          { 
            data: {
              id: @trip.id,
              start_location: @trip.start_location,
              end_location: @trip.end_location,
              start_time: @trip.start_time,
              rider: {
                id: @trip.rider.id,
                email: @trip.rider.email
              },              
              driver: {
                id: @trip.driver.id,
                email: @trip.driver.email
              },
              car: {
                id: @trip.car.id,
                license_plate: @trip.car.license_plate,
                car_type: @trip.car.car_type
              }                         
            }
          }.to_json
        else
          [422, { errors: @trip.errors }.to_json]
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

      def rider_authorized
        !Rider.rider_authorized(@data["email"]).present?
      end

      def rider_ongoing
        Rider.rider_ongoing(@data["email"]).present?
      end           

      def validation
        @contract_validation.errors.to_h.length > 0
      end      
    end
  end
end
