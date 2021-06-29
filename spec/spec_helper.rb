# frozen_string_literal: true
require 'rubygems'
require 'bundler'
Bundler.require :development
require 'capybara/rspec'
Combustion.initialize! :action_controller, :action_view
Bundler.require :default
require 'rspec/rails'
require 'capybara/rails'

RSpec.configure do |config|
  config.mock_with :rspec
end
