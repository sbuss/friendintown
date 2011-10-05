class AddMetadataToTours < ActiveRecord::Migration
  def self.up
    add_column :tours, :duration, :integer
    add_column :tours, :cost, :integer
  end

  def self.down
    remove_column :tours, :cost
    remove_column :tours, :duration
  end
end
