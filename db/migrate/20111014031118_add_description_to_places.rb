class AddDescriptionToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :description, :string
  end

  def self.down
    remove_column :places, :description
  end
end
