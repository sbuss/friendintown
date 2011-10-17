class DropLikes < ActiveRecord::Migration
  def self.up
    drop_table :likes
  end

  def self.down
    create_table :likes do |t|
      t.integer :tour_id
      t.integer :user_id

      t.timestamps
    end
    add_index :likes, [:tour_id, :user_id], :unique => true
  end
end
