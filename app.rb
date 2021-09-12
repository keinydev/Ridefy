require "sinatra"
require 'sinatra/cross_origin'
require "sinatra/activerecord"
require "sinatra/namespace"
require "./config/cors"
require "./lib/request_helper"
require './app/controllers/api/v1/riders_controller'
require './app/controllers/api/v1/payment_methods_controller'
require './app/controllers/api/v1/request_trips_controller'
require './app/controllers/api/v1/finish_trips_controller'
require './app/controllers/api/v1/charges_controller'

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
    { api: { v1: { documentation: "https://ridefy.docs.apiary.io/"}}}.to_json
  end

  namespace '/api/v1' do

	  get "/riders/:email/payment_methods" do
	  	@body_params = { "email" => params['email'] }
      Api::V1::RidersController.new(@body_params).get_payment_methods
	  end

	  post "/payment_methods" do
      Api::V1::PaymentMethodsController.new(@body_params).run
	  end

	  post "/trips" do
	    Api::V1::RequestTripsController.new(@body_params).run
	  end

	  put "/trips/:id" do
	  	@body_params.merge!(id: params['id'])
	    Api::V1::FinishTripsController.new(@body_params.transform_keys(&:to_s)).run
	  end	

	  put "/charges/:id" do
	  	@body_params.merge!(id: params['id'])
	    Api::V1::ChargesController.new(@body_params.transform_keys(&:to_s)).run
	  end		    
	end

  run! if app_file == $0
end
