class AddRatingsCacheToTour < ActiveRecord::Migration
  def self.up
    # 4.25 ==> precision = 3 (sigfigs), scale = 2 (after decimal)
    add_column :tours, :ratings_score, :decimal, :precision => 3, :scale => 2
    
    Tour.find(:all).each do |t|
      t.update_rating
    end
  end

  def self.down
    remove_column :tours, :ratings_score
  end
end
