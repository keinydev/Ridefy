require "sinatra"
require 'sinatra/cross_origin'
require "sinatra/activerecord"
require "sinatra/namespace"
require 'dotenv/load'
require "./config/cors"
require "./lib/request_helper"
require './app/controllers/api/v1/payment_methods_controller'
# require './app/controllers/riders_controller.rb'
# require './app/controllers/trips_controller.rb'

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

	  post "/trip" do
	    # data = parse_params(request.body.read)
     #  resultado = Api::V1::PaymentMethodsController.new.run(data)
	  end

	  post "/finish_trip" do
	    # data = parse_params(request.body.read)
     #  resultado = Api::V1::PaymentMethodsController.new.run(data)
	  end	  
	end

  run! if app_file == $0
end
