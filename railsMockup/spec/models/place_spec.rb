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
    end

    it "should have a stops attribute" do
      @place.should respond_to(:stops)
    end
  end
    
end
