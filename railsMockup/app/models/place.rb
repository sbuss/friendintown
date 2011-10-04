class Place < ActiveRecord::Base
  attr_accessible :name, :lat, :long 
end
