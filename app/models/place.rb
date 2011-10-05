class Place < ActiveRecord::Base
  attr_accessible :name, :lat, :long 
  has_many :stops
end
