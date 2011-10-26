class AddSlugsToExistingUsersAndTours < ActiveRecord::Migration
  def self.up
    Tour.initialize_urls
    User.initialize_urls
  end

  def self.down
    # Can't reliably reverse this without setting all URLs to blanks...
  end
end
