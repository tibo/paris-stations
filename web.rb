require 'sinatra'
require 'mongoid'
require 'json'

Mongoid.load!("./config/mongoid.yml")
Mongoid.logger.level = Logger::ERROR
Moped.logger.level = Logger::ERROR

if :production
  require 'newrelic_rpm'
end

require './models/station.rb'

class ParisStations < Sinatra::Application

  get '/' do
    send_file 'views/index.html'
  end

  get '/stations' do
    content_type :json

    if params[:ll].nil?
      halt 400, {:error => "Latitude and longitude required"}.to_json
    else
        
      latlong = params[:ll].split(',')

      if latlong.length != 2
        halt 400, {:error => "Invalid latitude and longitude"}.to_json
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

  get '/transport_types' do
    types = Station.distinct(:type)

    types.to_json
  end

end