class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :tour_id
      t.integer :user_id

      t.timestamps
    end
    add_index :likes, [:tour_id, :user_id], :unique => true
  end

  def self.down
    drop_table :likes
  end
end
