class AddNotesToStops < ActiveRecord::Migration
  def self.up
    add_column :stops, :notes, :string
  end

  def self.down
    remove_column :stops, :notes
  end
end
