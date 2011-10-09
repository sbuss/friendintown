class Stop < ActiveRecord::Base
  belongs_to :tour
  belongs_to :place
  attr_accessible :tour, :stop_num, :place_attributes, :place

  accepts_nested_attributes_for :place,
            :reject_if => :all_blank,
            :allow_destroy => false

  #validates :tour, :presence => true
  validates :stop_num, :presence     => true,
                       :numericality => { :greater_than => 0 ,
                                          :only_integer => true },
                       :uniqueness   => { :scope => :tour_id }
  
  default_scope :order => 'stops.stop_num ASC'

  def as_json(options = {})
    {
      id:       self.id,
      stop_num: self.stop_num,
      place:    self.place
    }
  end
end
