module Api
  module V1
    class RidersController

      def initialize(data)
        @data = data
      end

      def get_payment_methods
        return [404, { errors: { email: "Email not found" }}.to_json] if rider.nil?
        
        data = rider.payment_methods
        
        payment_method_list = []
        
        data.each do | pm |
          payment_method_list << { id: pm.id, method_type: pm.method_type, source_id: pm.source_id }
        end

        response = {
          data: payment_method_list
        }.to_json
      end     

      private 

      def rider
        @rider = Rider.find_by(email: @data["email"])
      end   
    end
  end
end
