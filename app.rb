require "sinatra"
require 'sinatra/cross_origin'
require "sinatra/activerecord"
require "sinatra/namespace"
require 'dotenv/load'
require "./config/cors"
require "./lib/request_helper"
require './app/controllers/api/v1/payment_methods_controller'
require './app/controllers/api/v1/request_trips_controller'

Dir["#{Dir.pwd}/app/models/*.rb"].each { |file| require file }

class App < Sinatra::Base

	register Sinatra::CrossOrigin
	register Sinatra::Namespace

	before do
    content_type 'application/json'

    if request.body.size > 0
    	@body_params = RequestHelpers::json_response(request.body.read)
  	end
  end

  get "/" do
    "Hello!"
  end

  namespace '/api/v1' do

	  post "/payment_method" do
      Api::V1::PaymentMethodsController.new(@body_params).run
	  end

	  post "/trips" do
	    Api::V1::RequestTripsController.new(@body_params).run
	  end

	  put "/trips/:id/finish" do
	    # data = parse_params(request.body.read)
     #  resultado = Api::V1::PaymentMethodsController.new.run(data)
	  end	  
	end

  run! if app_file == $0
end
