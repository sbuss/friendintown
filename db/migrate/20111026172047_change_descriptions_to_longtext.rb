class ChangeDescriptionsToLongtext < ActiveRecord::Migration
  def self.up
    change_column :places, :description, :text, :limit => 10000
    change_column :tours, :desc, :text, :limit => 10000
  end

  def self.down
    change_column :places, :description, :string, :limit => 255
    change_column :tours, :desc, :string, :limit => 255
  end
end
