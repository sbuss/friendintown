class Place < ActiveRecord::Base
  attr_accessor :name, :lat, :long, :order, :tour_id
  
  belongs_to :tour
  
  validates :tour_id, :presence => true
  
  default_scope :order => 'places.tour_id DESC'
end
