require 'rubygems'

if ENV['RACK_ENV'] != 'production'
	require 'rspec/core/rake_task'
end

require 'mongoid'
require './models/station.rb'
require 'csv'

ENV['RACK_ENV'] ||= 'development'

if ENV['RACK_ENV'] != 'production'
	RSpec::Core::RakeTask.new do |task|
	  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
	  task.pattern    = 'spec/**/*_spec.rb'
	end
end

namespace :data do
  desc "Import Datas"
  task :import do

  	Mongoid.load!('./config/mongoid.yml')
	Mongoid.logger.level = Logger::ERROR
	Moped.logger.level = Logger::ERROR

	Station.delete_all

	file = './data/ratp_arret_graphique_01.csv'

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

	begin
		Station.create_indexes
	rescue Object => e
		warn "error creating indexes on Station"
		warn "run: db.stations.ensureIndex({\"location\":\"2d\"}) to create it manualy"
	end
  end
end