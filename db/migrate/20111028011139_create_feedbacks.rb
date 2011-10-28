class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.integer :user_id
      t.string :page
      t.integer :score
      t.text :comment

      t.timestamps
    end
    add_index :feedbacks, :page
  end

  def self.down
    drop_table :feedbacks
  end
end
