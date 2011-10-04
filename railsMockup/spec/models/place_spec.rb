require 'spec_helper'

describe Place do
  before(:each) do
    @attr = { :name => "McFakey's", :lat => 13.45, :long => 66.634 }
  end

  it "can be create with valid attributes" do
    Place.create!(@attr)
  end

  it "correctly stores lat and long" do
    Place.create!(@attr.merge(:name => "test"))
    p = Place.first
    # Sanity check
    p.name.should == "test"
    p.lat.should == @attr[:lat]
    p.long.should == @attr[:long]
  end

  describe "Associate stops" do
    before(:each) do
      @place = Place.create(@attr)
      @stop_1 = Factory(:stop, :tour => Factory(:tour), :place => @place)
      @stop_2 = Factory(:stop, :tour => Factory(:tour), :place => @place)
    end

    it "should have a stops attribute" do
      @place.should respond_to(:stops)
    end

    it "should have multiple stops at this place" do
      @place.stops.size.should == 2
    end

    it "should have the correct stops, in any order" do
      @place.stops.should =~ [@stop_1, @stop_2]
    end
  end
end
