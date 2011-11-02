require 'spec_helper'
###################################
# DO NOT NEED THIS YET, LEAVE OUT
##################################
#
describe "LayoutLinks" do

  before(:each) do
    #
    # Define @base_title here.
    #

    @base_title = "Juicee!"
  end

  describe "when not signed in" do
    it "should have a signin link" do
      visit root_path
      response.should have_selector("a", :href => signin_path,
                                         :content => "Sign In")
    end

    it "should have a register link" do
      visit root_path
      response.should have_selector("a", :href => register_path,
                                         :content => "Register")
    end
  end

  describe "when signed in" do

    before(:each) do
      @user = Factory(:user)

      visit signin_path

      fill_in "User Name",    :with => @user.user_name
      fill_in "Password", :with => @user.password
      click_button
    end

    it "should have a signout link" do
      visit root_path
      response.should have_selector("a", :href => signout_path,
                                         :content => "Sign Out")
    end

    it "should have a profile link" do
      visit root_path
      response.should have_selector("a", :href => user_path(@user),
                                         :content => "Profile")
    end

    it "should have a Home page at '/'" do
        get "/", :id => @user
        response.should be_success

    end
  end


end

