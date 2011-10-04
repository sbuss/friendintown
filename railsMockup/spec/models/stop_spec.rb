require 'spec_helper'

describe Stop do
  before(:each) do
    @tour = Factory(:tour)
    @attr = { :tour => Factory(:tour), :place => Factory(:place), :stop_num => 0 }
  end

  describe "failures" do
    it "A stop must be associated with a tour" do
    end
  end

  describe "success" do
    it "can be created with valid attributes" do
      Stop.create(@attr)
      @tour.stops.create!(@attr)
    end
  end

end
