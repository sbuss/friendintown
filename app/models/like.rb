class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :tour

  validates :tour_id, :uniqueness => { :scope => [:user_id] }

  def as_json(options = {})
    {
      :user => self.user,
      :tour => self.tour
    }
  end
end
