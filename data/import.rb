require 'mongoid'
require '../station.rb'
require 'csv'

Mongoid.load!("../mongoid.yml", :development)
Mongoid.logger.level = Logger::DEBUG
Moped.logger.level = Logger::DEBUG

Station.delete_all

CSV.foreach('ratp_arret_graphique_01.csv', col_sep: '#') do |row|

	puts row.inspect
	
	station = Station.new()

	station.ratp_id = row[0].to_i

	station.location = [row[2].to_f, row[1].to_f]

	station.name = row[3]
	station.city = row[4]
	station.type = row[5]
	
	station.save


end