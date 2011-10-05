class ChangeLatLngToDecimalsInPlace < ActiveRecord::Migration
  def self.up
    remove_column :places, :lat
    remove_column :places, :long
    add_column :places, :lat, :decimal, :precision => 15, :scale => 10
    add_column :places, :long, :decimal, :precision => 15, :scale => 10
  end

  def self.down
    remove_column :places, :lat
    remove_column :places, :long
    add_column :places, :lat, :string
    add_column :places, :long, :string
  end
end
