require 'spec_helper'

describe Subscription do
  before(:each) do
    @attr = { :email => "foo.bar+baz@example.com.au" }
  end

  it "should create a new subscription" do
    sub = Subscription.new(@attr)
    sub.should be_valid
  end

  it "should not allow empty emails" do
    empty_email = Subscription.new(:email => "")
    empty_email.should_not be_valid
  end

  it "should not allow invalid emails" do
    invalid_emails = %w[bad@foo bad_at_foo]
    invalid_emails.each do |email|
      empty_email = Subscription.new(:email => email)
      empty_email.should_not be_valid
    end
  end

  it "should not allow duplicate emails" do
    Subscription.create!(@attr)
    dupe_sub = Subscription.new(@attr)
    dupe_sub.should_not be_valid
  end

  it "should not allow duplicate emails, regardless of case" do
    Subscription.create!(@attr)
    dupe_sub = Subscription.new(@attr.merge( :email => @attr[:email].upcase))
    dupe_sub.should_not be_valid
  end
end
