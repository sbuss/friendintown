require 'spec_helper'

describe "subscriptions/edit.html.erb" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Subscription,
      :email => "MyString"
    ))
  end

  it "renders the edit subscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscriptions_path(@subscription), :method => "post" do
      assert_select "input#subscription_email", :name => "subscription[email]"
    end
  end
end
