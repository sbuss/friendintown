class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :name
      t.string :lat
      t.string :long
      t.integer :order
      t.integer :tour_id

      t.timestamps
    end
  end

  def self.down
    drop_table :places
  end
end
