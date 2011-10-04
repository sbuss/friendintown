require 'spec_helper'

describe "subscriptions/new.html.erb" do
  before(:each) do
    assign(:subscription, stub_model(Subscription,
      :email => "MyString"
    ).as_new_record)
  end

  it "renders new subscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => subscriptions_path, :method => "post" do
      assert_select "input#subscription_email", :name => "subscription[email]"
    end
  end
end
