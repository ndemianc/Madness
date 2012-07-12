require 'spec_helper'

describe "FriendlyForwardings" do
  describe "for non-signed-in users" do
    it "should forward to the requested page after sign in" do
      @user = Factory(:user)
      visit edit_user_path(@user)
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
      response.should render_template('users/edit')
      visit signout_path
      visit signin_path
      fill_in :email,    :with => @user.email
      fill_in :password, :with => @user.password
      click_button
      response.should render_template('users/show')
    end
  end

  describe "for signed-in users" do
    before(:each) do
      wrong_user = Factory(:user, :email => "user@example.net")
      test_sign_in(wrong_user)
    end

    it "should require matching user for 'edit'" do
      get :edit, :id => @wrong_user
      response.should redirect_to(root_path)
    end
    
    it "should require matching user for 'update'" do
      put :update, :id => @wrong_user, :user => {}
      response.should redirect_to(root_path)
    end

  end
end
