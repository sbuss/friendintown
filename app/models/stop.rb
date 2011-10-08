class Stop < ActiveRecord::Base
  belongs_to :tour
  has_one :place

  accepts_nested_attributes_for :place,
            :reject_if => lambda { |p| p.name.empty? },
            :allow_destroy => false

  validates :tour_id, :presence => true
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
