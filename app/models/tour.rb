class Tour < ActiveRecord::Base
  # Note, duration is in MINUTES
  attr_accessor :user
  attr_accessible :name, :desc, :duration, :cost

  belongs_to :user
  has_many :stops, :dependent => :destroy

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
