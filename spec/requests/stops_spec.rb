require 'spec_helper'

describe "Stops" do
  describe "new" do
    describe "failure" do
      it "should not make a new stop" do
        lambda do
          visit new_stop_path
          fill_in "Stop num",   :with => ""
          fill_in "Name",       :with => ""
          fill_in "Lat",        :with => ""
          fill_in "Long",       :with => ""
          click_button
          response.should render_template('stops/new')
        end.should_not change(Stop, :count)
      end
    end

    describe "success" do
      it "should make a new stop and place" do
        lambda do
          lambda do
            visit new_stop_path
            fill_in "Stop num",   :with => "1"
            fill_in "Name",       :with => "Some place"
            fill_in "Lat",        :with => "45.456"
            fill_in "Long",       :with => "-66.354"
            click_button
          end.should change(Stop, :count).by(1)
        end.should change(Place, :count).by(1)
      end
    end
  end
end
