class Stop < ActiveRecord::Base
  belongs_to :tour
  has_one :place

  validates :tour_id, :presence => true
  
  default_scope :order => 'stops.tour_id ASC'
end
