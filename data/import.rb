require 'mongoid'
require File.join(File.dirname(__FILE__), '../station.rb')
require 'csv'

Mongoid.load!(File.join(File.dirname(__FILE__), '../mongoid.yml'))
Mongoid.logger.level = Logger::ERROR
Moped.logger.level = Logger::ERROR

Station.delete_all

# http://data.ratp.fr/?eID=ics_od_datastoredownload&file=64
file = File.join(File.dirname(__FILE__), 'ratp_arret_graphique_01.csv')

CSV.foreach(file, col_sep: '#') do |row|

	latitude = row[2].to_f
	longitude = row[1].to_f

	if latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180
		
		station = Station.new()

		station.ratp_id = row[0].to_i

		station.location = [latitude, longitude]

		station.name = row[3]
		station.city = row[4]
		station.type = row[5]
		
		station.save

	else
		puts "ERROR with data:"
		puts row.inspect
	end
	
end

puts "may need to run: db.stations.ensureIndex({\"location\":\"2d\"})"