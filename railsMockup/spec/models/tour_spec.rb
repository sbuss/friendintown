require 'spec_helper'

describe Tour do
  before(:each) do
    @attr = {
      :name => "Test tour",
      :desc => "Has a description"
    }
  end

  describe "valid creation" do
    it "can be created with valid attributes" do
      Tour.create!(@attr)
    end

    it "can be created with a name of 5 chars" do
      ok_name_tour = Tour.new(@attr.merge(:name => "a"*5))
      ok_name_tour.should be_valid
    end

    it "can be created without a description" do
      no_desc_tour = Tour.new(@attr.merge(:desc => ""))
      no_desc_tour.should be_valid
    end
  end

  describe "Invalid creation" do
    it "should have a name attribute" do
      no_name_tour = Tour.new(@attr.merge(:name => ""))
      no_name_tour.should_not be_valid
    end

    it "should have a title at least 5 characters long" do
      short_name_tour = Tour.new(@attr.merge(:name => "a"*4))
      short_name_tour.should_not be_valid
    end

    it "should not allow the same title twice" do
      my_attr = @attr.merge(:name => "Non-unique title")
      good_tour = Tour.create!(my_attr)
      good_tour.should be_valid
      dupe_tour = Tour.new(my_attr)
      dupe_tour.should_not be_valid
    end
  end

  describe "Add stops" do
    before(:each) do
      @tour = Tour.create(@attr)
      @stop_1 = Factory(:stop, :tour => @tour, :place => Factory(:place), 
                        :stop_num => 1)
      @stop_0 = Factory(:stop, :tour => @tour, :place => Factory(:place), 
                        :stop_num => 0)
    end

    it "should have a stops attribute" do
      @tour.should respond_to(:stops)
    end

    it "should have the right stops in the right order" do
      @tour.stops.should == [@stop_0, @stop_1]
    end

  end
    
end
