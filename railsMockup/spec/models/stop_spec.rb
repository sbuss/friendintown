require 'spec_helper'

describe Stop do
  before(:each) do
    @tour = Factory(:tour)
    @attr = { :place => Factory(:place), :order => 0 }
  end

  describe "A stop must be associated with a tour"

  describe "success" do
    it "can be created with valid attributes" do
      @tour.stops.create!(@attr)
    end
  end

end
