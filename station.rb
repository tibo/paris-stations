require 'mongoid'

class Station
  include Mongoid::Document

  field :ratp_id, type: Integer

  field :location, :type => Array  # [lat,lng]
  index({ location: "2d" }, { min: -180, max: 180 })

  field :name, type: String
  field :city, type: String
  field :type, type: String

  def to_json
  	return {:name => self.name}.to_json
  end
end