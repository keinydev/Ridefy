require "sinatra"
require 'sinatra/cross_origin'
require "sinatra/activerecord"
require "sinatra/namespace"
require "./config/cors"
require './app/controllers/api/v1/payment_methods_controller.rb'
# require './app/controllers/riders_controller.rb'
# require './app/controllers/trips_controller.rb'

class App < Sinatra::Base

	register Sinatra::CrossOrigin
	register Sinatra::Namespace

	before do
    content_type 'application/json'
  end

  get "/" do
    "Hello!"
  end

  namespace '/api/v1' do

	  post "/payment_method" do
	    data = parse_params(request.body.read)
      resultado = Api::V1::PaymentMethodsController.new.run(data)
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

	def parse_params(params)
    JSON.parse(params).deep_symbolize_keys!
  end

  run! if app_file == $0
end
