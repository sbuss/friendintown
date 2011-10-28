class Feedback < ActiveRecord::Base
  belongs_to :user
  
  validates :comment, :length   => { :minimum => 5 }, 
                      :unless => Proc.new {|obj| obj.comment.blank? }
  validates :score, :numericality => { :greater_than => 0,
                                       :less_than => 6 }, 
                    :unless => proc {|obj| obj.score.blank? }
  validate :score_or_comment

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

  private
    def score_or_comment
      if score.blank? && comment.blank?
        errors.add_to_base("Either a star rating or a comment is required.")
      end
    end
end
