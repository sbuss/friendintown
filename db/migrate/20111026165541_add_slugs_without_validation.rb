class AddSlugsWithoutValidation < ActiveRecord::Migration
  def self.up
    Tour.where(:url => nil).each do |t|
      t.send :ensure_unique_url
      t.save(:validate => false)
    end

    User.where(:url => nil).each do |u|
      u.send :ensure_unique_url
      u.save(:validate => false)
    end
  end

  def self.down
  end
end
