require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name => "Sergii", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" }
  end

  describe "admin attribute" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin be default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end

  end

end
