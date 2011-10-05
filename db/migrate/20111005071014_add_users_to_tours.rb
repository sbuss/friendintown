class AddUsersToTours < ActiveRecord::Migration
  def self.up
    add_column :tours, :user_id, :integer
    add_index :tours, :user_id 
  end

  def self.down
    remove_column :tours, :user_id
  end
end
