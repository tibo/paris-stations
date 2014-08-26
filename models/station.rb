require 'mongoid'

class Station
  include Mongoid::Document

  field :ratp_id, type: Integer

  field :location, :type => Array  # [lat,lng]
  index({ location: "2d" }, { min: -180, max: 180 })

  field :name, type: String
  field :city, type: String
  field :type, type: String

  def as_json(options={})
    attrs = super(options)
    
    attrs.delete("_id")

    attrs.delete("location")
    attrs = attrs.merge({"latitude" => self.location[0]})
    attrs = attrs.merge({"longitude" => self.location[1]})

    attrs
  end
end