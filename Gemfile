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

gem "http"
gem "tux"

group :development, :test do
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
