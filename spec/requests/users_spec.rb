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
end
