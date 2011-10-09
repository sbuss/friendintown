require 'spec_helper'

describe Like do
  describe "success" do
    before(:each) do
      @user = Factory(:user)
      @tour = Factory(:tour)
    end

    it "Should allow a user to like a tour" do
      lambda do
        @user.likes.create(@tour)
      end.should change(Like, :count).by(1)
    end

    it "Shouldn't allow a user to like a tour twice" do
      lambda do
        @user.likes.create(@tour)
        @user.likes.create(@tour)
      end.should change(Like, :count).by(1)

    end
  end
end
