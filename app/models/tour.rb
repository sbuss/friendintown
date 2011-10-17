class Tour < ActiveRecord::Base
  # Note, duration is in MINUTES
  attr_accessor :user
  #attr_accessible :name, :desc, :duration, :cost, :stops_attributes

  belongs_to :user
  has_many :stops, :inverse_of => :tour, :dependent => :destroy
  has_many :places, :through => :stops
  has_many :ratings

  accepts_nested_attributes_for :stops, 
        :reject_if => proc { |s| s['stop_num'].empty? },
        :allow_destroy => true

  validates :user_id, :presence => true
  validates :name, :presence    => true, 
                   :length      => { :minimum => 5 },
                   :uniqueness  => { :case_sensitive => false }

  default_scope :order => 'tours.ratings_score DESC'

  # Allow tours to be looked up by their name, instead of their id
  acts_as_url :name
  def to_param
    url
  end

  # Helper method to display the cached bayes rating with 2 trailing digits
  def ratings_score_formatted
    sprintf("%1.1f", self.ratings_score)
  end

  # Update the bayesian score estimate.
  # Return nil if there are no ratings for the tour, 
  # or the bayesian estimate if the tour has ratings.
  def update_rating
    return nil if self.ratings.count <= 0
    self.ratings_score = calc_bayes_rating_score
    self.save
    self.ratings_score
  end

  # Calculate the bayesian estimate of actual score
  def calc_bayes_rating_score
    # FROM: http://www.thebroth.com/blog/118/bayesian-rating
    #
    # NOTE: There is a scalability issue doing it this way. This bayesian 
    # extimate should be re-run for every tour after any rating on any tour is 
    # added, changed, or deleted. This is because the bayesian priors are 
    # based on the whole dataset. Once we have enough data in the system, we 
    # can declate the priors to be constants, since they will fluctuate very 
    # little at scale. That's nice... a scalability problem that can only be 
    # solved at scale.
    #
    # br = ( (avg_num_ratings_all_items * avg_rating_all_items) +
    #        (num_ratings_this_item * avg_rating_this_item) ) /
    #      (avg_num_ratings_all_items * num_ratings_this_item)
    # Find the average number of ratings
    num_all_ratings = Rating.count(:all).to_f
    # Find the number of tours with ratings
    num_items = Rating.count(:tour_id, :distinct => true).to_f
    avg_num_ratings_all_items = num_all_ratings / num_items
    # Find the average rating given to all tours
    avg_rating_all_items = Rating.average(:score)
    # Numerator part 1
    numerator = avg_num_ratings_all_items * avg_rating_all_items

    # Find the number of ratings for this tour
    num_ratings_this_item = self.ratings.count.to_f
    # Find the average rating for this tour
    avg_rating_this_item = self.ratings.average(:score)
    # Numerator part 2
    numerator += num_ratings_this_item * avg_rating_this_item
    denominator = avg_num_ratings_all_items * num_ratings_this_item
    # Return the bayesian estimate, bounded at (1,5)
    @bayes_rating_score = [5, [1, numerator / denominator].max].min
  end

  def as_json(options = {})
    {
      :id =>       self.id,
      :name =>     self.name,
      :stops =>    self.stops,
      :cost =>     self.cost,
      :duration => self.duration
    }
  end

end
