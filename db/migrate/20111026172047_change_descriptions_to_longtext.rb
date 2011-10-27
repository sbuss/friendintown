class ChangeDescriptionsToLongtext < ActiveRecord::Migration
  def self.up
    change_column :places, :description, :text
    change_column :tours, :desc, :text
  end

  def self.down
    change_column :places, :description, :string, :limit => 255
    change_column :tours, :desc, :string, :limit => 255
  end
end
