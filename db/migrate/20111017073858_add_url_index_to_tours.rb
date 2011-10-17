class AddUrlIndexToTours < ActiveRecord::Migration
  def self.up
    add_index :tours, :url
  end

  def self.down
    remove_index :tours, :url
  end
end
