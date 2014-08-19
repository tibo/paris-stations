require 'sinatra'
require 'mongoid'
require 'json'

Mongoid.load!("mongoid.yml")
Mongoid.logger.level = Logger::DEBUG
Moped.logger.level = Logger::DEBUG

require './station.rb'

get '/' do
  content_type :json

  if params[:ll].nil?
    halt 500, {:error => "Latitude and longitude required"}.to_json
  else
      
    latlong = params[:ll].split(',')

    if latlong.length != 2
      halt 500, {:error => "Invalid latitude and longitude"}.to_json
    else

      number_of_results = 10

      if !params[:n].nil?
        number_of_results = params[:n].to_i
      end

      lat = latlong.first.to_f
      lng = latlong[1].to_f

      if params[:types]
        types = params[:types].split(',')

        if types.length > 0
          stations = Station.where(type: {'$in' => types}).limit(number_of_results).geo_near([ lat, lng ])
        end

      else
        stations = Station.limit(number_of_results).geo_near([ lat, lng ])
      end
      
      stations.to_json
    end
  end

end