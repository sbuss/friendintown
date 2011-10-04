require 'spec_helper'

describe "subscriptions/index.html.erb" do
  before(:each) do
    assign(:subscriptions, [
      stub_model(Subscription,
        :email => "Email"
      ),
      stub_model(Subscription,
        :email => "Email"
      )
    ])
  end

  it "renders a list of subscriptions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
  end
end
