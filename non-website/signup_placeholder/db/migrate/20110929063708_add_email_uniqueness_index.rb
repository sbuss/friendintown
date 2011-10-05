class AddEmailUniquenessIndex < ActiveRecord::Migration
  def self.up
    add_index :subscriptions, :email, :unique => true
  end

  def self.down
    remove_index :subscriptions, :email
  end
end
