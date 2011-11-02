require 'spec_helper'

#################################
# DO NOT NEED THIS YET, LEAVING OUT - Bryan L.
#################################

describe "Users" do

  describe "signup" do

    describe "failure" do

      it "should not make a new user" do

        lambda do
          visit register_path
          fill_in "First Name",         :with => ""
          fill_in "Last Name", :with => ""
          fill_in "User Name", :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirm Password", :with => ""
          click_button

          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end

    describe "success" do

      it "should make a new user" do
        lambda do
          visit register_path
          fill_in "First Name",         :with => "Johnny"
          fill_in "Last Name", :with => "Appleseed"
          fill_in "User Name", :with => "j_apple"
          fill_in "Email",        :with => "japplesee@gmail.com"
          fill_in "Password",     :with => "foobar1123"
          fill_in "Confirm Password", :with => "foobar1123"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
          response.should render_template('users/show')
        end.should change(User, :count).by(1)
      end
    end

  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in "User Name", :with => ""
        fill_in "Password", :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path


        fill_in "User Name",    :with => user.user_name
        fill_in "Password", :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end
