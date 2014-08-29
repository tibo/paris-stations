require 'bundler/setup'
require 'sinatra'

Sinatra::Base.set :environment, :test
Bundler.require :default, Sinatra::Application.environment

require 'rspec'
require File.dirname(__FILE__) + '/../web.rb'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  
end

def app
	ParisStations
end