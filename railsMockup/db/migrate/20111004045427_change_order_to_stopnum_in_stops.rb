class ChangeOrderToStopnumInStops < ActiveRecord::Migration
  def self.up
    rename_column(:stops, :order, :stop_num)
  end

  def self.down
    rename_column(:stops, :stop_num, :order)
  end
end
