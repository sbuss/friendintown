class CreateStops < ActiveRecord::Migration
  def self.up
    create_table :stops do |t|
      t.integer :tour_id
      t.integer :place_id
      t.integer :order

      t.timestamps
    end
    add_index :stops, [:tour_id, :place_id, :order]
  end

  def self.down
    drop_table :stops
  end
end
