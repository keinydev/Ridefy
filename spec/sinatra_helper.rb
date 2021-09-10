require 'rspec'
require 'rack/test'
require 'spec_helper'
require 'factory_bot'
require 'shoulda-matchers'
require 'database_cleaner'
require './spec/support/request_helper'
# require '../app/controllers/api/v1/request_trips_controller'

ENV['RACK_ENV'] ||= 'test'

require "./config/environment"

require File.expand_path '../../app.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end
end

RSpec.configure do |config|

  # config.before(:each) do
  #   $db = []
  # end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include FactoryBot::Syntax::Methods

	config.include RSpecMixin
	
  config.include Request::Helpers, type: :request

  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.before(:suite) do
  	DatabaseCleaner.clean_with(:truncation)
    FactoryBot.find_definitions
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.before(:all) do
    DatabaseCleaner.start
  end

  config.after(:all) do
    DatabaseCleaner.clean
  end

  Shoulda::Matchers.configure do |config|
	  config.integrate do |with|
	    with.test_framework :rspec

	    # Keep as many of these lines as are necessary:
	    with.library :active_record
	    with.library :active_model
	  end
	end
end
