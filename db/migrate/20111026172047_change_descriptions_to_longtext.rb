class ChangeDescriptionsToLongtext < ActiveRecord::Migration
  def self.up
    change_column :places, :description, :text, :limit => 16777215 #MEDIUMTEXT
    change_column :tours, :desc, :text, :limit => 16777215
  end

  def self.down
    change_column :places, :description, :string, :limit => 255
    change_column :tours, :desc, :string, :limit => 255
  end
end
