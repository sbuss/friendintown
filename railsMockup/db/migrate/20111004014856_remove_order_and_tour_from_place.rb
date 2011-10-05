class RemoveOrderAndTourFromPlace < ActiveRecord::Migration
  def self.up
    remove_column :places, :order
    remove_column :places, :tour_id
  end

  def self.down
    add_column :places, :tour_id, :integer
    add_column :places, :order, :integer
  end
end
