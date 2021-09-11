# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

ruby '~> 2.7.3'

# Framework
gem "sinatra"
gem "sinatra-contrib"

# Database
gem "pg"
gem "rake"
gem "sinatra-activerecord"

# Data
gem "faker"

# Api
gem "sinatra-cross_origin"

# Dry Gems
gem "dry-validation"

# Request
gem "http"

# Time
gem "time_difference"

# Geo 
gem "geocoder"

group :development, :test do
	gem "tux"
  gem "rerun"
  gem "dotenv", groups: [:development, :test]
end

group :test do
	gem 'rspec', '~> 3.0'
	gem 'rack-test'
	gem 'factory_bot'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'database_cleaner'
end
