require 'bundler/setup'
require 'sinatra'

Sinatra::Base.set :environment, :test
Bundler.require :default, Sinatra::Application.environment

require 'rspec'
require File.dirname(__FILE__) + '/../web.rb'

RSpec.configure do |config|
  
end

def app
	ParisStations
end