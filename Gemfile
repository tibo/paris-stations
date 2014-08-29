source 'https://rubygems.org'
ruby "2.0.0"

gem 'rake'

gem 'sinatra', '~> 1.4.5'

gem "mongoid", "~> 4.0.0"

group :production do
	gem 'newrelic_rpm'
end

group :test do
	gem 'rspec'
	gem 'rack-test'
	gem 'coveralls', require: false
end