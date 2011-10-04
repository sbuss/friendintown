class Tour < ActiveRecord::Base
  attr_accessible :name, :desc

  has_many :stops, :dependent => :destroy

  validates :name, :presence    => true, 
                   :length      => { :minimum => 5 },
                   :uniqueness  => { :case_sensitive => false }
  

end
