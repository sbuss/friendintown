require 'spec_helper'

describe Place do
  before(:each) do
    @attr = { :name => "McFakey's", :lat => 13.45, :long => 66.634 }
  end

  it "can be create with valid attributes" do
    Place.create!(@attr)
  end
end
