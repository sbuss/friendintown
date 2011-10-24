class AddUrlToTour < ActiveRecord::Migration
  def self.up
    add_column :tours, :url, :string
  end

  def self.down
    remove_column :tours, :url
  end
end
