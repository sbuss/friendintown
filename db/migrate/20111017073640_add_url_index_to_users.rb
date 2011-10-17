class AddUrlIndexToUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :url
  end

  def self.down
    remove_index :users, :url
  end
end
