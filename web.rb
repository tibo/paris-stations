require 'sinatra'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql', 
  database: 'subway', 
  encoding: 'unicode', 
  pool: 5, 
  username: 'tibo', 
  password: '', 
  host: 'localhost' )

class Station < ActiveRecord::Base
end

get '/' do
  stations = Station.all()
  stations.to_json
end