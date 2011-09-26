class Tour < ActiveRecord::Base
  attr_accessible :name, :desc
  
  has_many :places, :dependent => :destroy

end
