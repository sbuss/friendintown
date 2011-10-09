require 'spec_helper'

describe "Tours" do
  before(:each) do
    user = Factory(:user)
    visit signin_path
    fill_in :email,     :with => user.email
    fill_in :password,  :with => user.password
    click_button
  end

  describe "new" do
    describe "failure" do
      it "should not make a new tour" do
        lambda do
          visit new_tour_path
          fill_in "Name",       :with => ""
          fill_in "Duration",   :with => ""
          fill_in "Cost",       :with => ""
          fill_in "Desc",       :with => ""
          fill_in "Stop num",   :with => ""
          fill_in "Name",       :with => ""
          fill_in "Lat",        :with => ""
          fill_in "Long",       :with => ""
          click_button
          response.should render_template('tours/new')
        end.should_not change(Tour, :count)
      end
    end

    describe "success" do
      it "should make a new tour, stop, and place" do
        lambda do
          lambda do
            lambda do
              visit new_tour_path
              fill_in "Name",       :with => "Some tour"
              fill_in "Duration",   :with => "45"
              fill_in "Cost",       :with => "115"
              fill_in "Desc",       :with => "A description"
              fill_in "Stop num",   :with => "1"
              fill_in "Name",       :with => "Some place"
              fill_in "Lat",        :with => "45.456"
              fill_in "Long",       :with => "-66.354"
              click_button
            end.should change(Tour, :count).by(1)
          end.should change(Stop, :count).by(1)
        end.should change(Place, :count).by(1)
      end
    end
  end
end
