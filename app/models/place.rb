class Place < ActiveRecord::Base
  attr_accessible :name, :lat, :long 
  has_many :stops

  def as_json(options = {})
    {
      id:   self.id,
      name: self.name,
      lat:  self.lat,
      long: self.long
    }
  end
end
