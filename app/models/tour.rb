class Tour < ActiveRecord::Base
  # Note, duration is in MINUTES
  attr_accessor :user
  #attr_accessible :name, :desc, :duration, :cost, :stops_attributes

  belongs_to :user
  has_many :stops, :dependent => :destroy
  has_many :places, :through => :stops
  accepts_nested_attributes_for :stops, 
        :reject_if => proc { |s| s['stop_num'].empty? },
        :allow_destroy => true

  validates :user_id, :presence => true
  validates :name, :presence    => true, 
                   :length      => { :minimum => 5 },
                   :uniqueness  => { :case_sensitive => false }


  def as_json(options = {})
    {
      id:       self.id,
      name:     self.name,
      stops:    self.stops,
      cost:     self.cost,
      duration: self.duration
    }
  end

end
