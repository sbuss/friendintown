require 'spec_helper'

describe "subscriptions/show.html.erb" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :email => "Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
  end
end
