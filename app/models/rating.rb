class Rating < ActiveRecord::Base
  attr_accessible :score, :comment

  belongs_to :tour
  belongs_to :user

  validates :tour, :presence => true
  validates :user, :presence => true
  validates :comment, :presence => true,
                      :length   => { :minimum => 5 }
  validates :score, :presence     => true,
                    :numericality => { :greater_than => 0,
                                       :less_than => 6 }

  VALID_RATINGS = (1..5).to_a

  def as_json(options = {})
    {
      :id      => self.id,
      :tour    => self.tour.id,
      :user    => self.user.id,
      :score   => self.score,
      :comment => self.comment
    }
  end
end
