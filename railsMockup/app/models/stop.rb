class Stop < ActiveRecord::Base
  belongs_to :tour
  belongs_to :place

  validates :tour_id, :presence => true
  validates :stop_num, :presence     => true,
                       :numericality => { :greater_than_or_equal_to => 0 ,
                                          :only_integer => true }
  
  default_scope :order => 'stops.stop_num ASC'
end
