require './lib/utils.rb'
require './app/controllers/validators/finish_trip_contract.rb'

module Api
  module V1
    class FinishTripsController

      BASE_FEE = 3500
      PRICE_KM = 1000
      PRICE_MIN = 200

      def initialize(data)
        @data = data
        @contract_validation = FinishTripContract.new.call(@data)
      end

      def run
        return [400, { errors: @contract_validation.errors.to_h }.to_json]                    if validation
        return [404, { errors: { trip: "Trip not found" }}.to_json]                           if trip.nil?
        return [403, { errors: { trip: "This trip has ended, no changes applied" }}.to_json]  if trip.end_time.present?
        
        calculate_price
      end

      def update_trip
        @data = @data.transform_keys(&:to_s)

        if trip.update(end_time: @data["end_time"], end_location: @data["end_location"])
          
          @charge = Charge.new(total: @data["total"], trip_id: trip.id)
          @charge.save

          response = { 
            data: { 
              id: trip.id,
              start_location: trip.start_location,
              end_location: trip.end_location,
              start_time: trip.start_time,
              end_time: trip.end_time,
              rider: {
                id: trip.rider.id,
                email: trip.rider.email
              },              
              driver: {
                id: trip.driver.id,
                email: trip.driver.email
              },
              car: {
                id: trip.car.id,
                license_plate: trip.car.license_plate,
                car_type: trip.car.car_type
              },              
              charge: {
                id: @charge.id,
                total: @charge.total
              }
            } 
          }.to_json
        else
          [422, { errors: trip.errors }.to_json]
        end
      end     

      private 
      
      def trip
        @trip = Trip.find(@data["id"]) rescue nil
      end

      def calculate_price
        end_time = Time.now

        start_location = trip.start_location.transform_values(&:to_f).values
        end_location = @data["end_location"].transform_values(&:to_f).values

        distance = Utils::distance_between(start_location, end_location)
        minutes = Utils::calculate_minutes(trip.start_time, end_time)

        price = ((distance * PRICE_KM) + (minutes * PRICE_MIN) + BASE_FEE).round(2)

        @data.merge!(total: price, end_time: end_time)

        update_trip
      end

      def validation
        @contract_validation.errors.to_h.length > 0
      end      
    end
  end
end
