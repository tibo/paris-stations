require 'sinatra'
require 'mongoid'
require 'json'

Mongoid.load!("mongoid.yml")
Mongoid.logger.level = Logger::DEBUG
Moped.logger.level = Logger::DEBUG

require './station.rb'

get '/' do
  content_type :json

  latlong = params[:ll].split(',')

  if latlong.length == 2

    lat = latlong.first.to_f
    lng = latlong[1].to_f

    stations = Station.limit(10).geo_near([ lat, lng ])
    stations.to_json

  else
    halt(500)
  end

end