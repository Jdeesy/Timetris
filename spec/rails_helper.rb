ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'simplecov'
require 'ostruct'
# require 'cabybara/rails'

# Start SimpleCov for test coverage report
SimpleCov.start

# Maintain Active Record test Schema
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
