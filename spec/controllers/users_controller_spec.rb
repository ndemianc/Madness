require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'edit'" do\

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @user
      response.should have_selector('title', :content => "Edit user")
    end

    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      response.should have_selector('a', :href => 'http://gravatar.com/emails',
                                         :content => "change")
    end
  end

  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end
      describe "failure" do
        before(:each) do
          @attr = { :name => "", :email => "", :password => "",
                    :password_confirmation => "" }

        end

        it "should render the 'edit' page" do
          put :update, :id => @user, :user => @attr
          response.should render_template('edit')
        end

        it "should have the right title" do
          put :update, :id => @user, :user => @attr
          response.should have_selector('title', :content => "Edit user")
        end
      end

      describe "success" do
        before(:each) do
          @attr = { :name => "New Name", :email => "user@example.org",
                     :password => "foobaz", :password_confirmation => "foobaz" }

        end
        it "should change the user's attributes" do
          put :update, :id => @user, :user => @attr
          user = assigns(:user)
          @user.reload
          @user.name.should == user.name
          @user.email.should == user.email
          @user.encrypted_password == user.encrypted_password
        end

        it "should have a flash message" do
          put :update, :id => @user, :user => @attr
          flash[:success].should =~ /updated/
        end
      end

  end

end
