class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :tour_id
      t.integer :score
      t.string :comment

      t.timestamps
    end
    add_index :ratings, :tour_id
    add_index :ratings, :user_id
  end

  def self.down
    drop_table :ratings
  end
end
