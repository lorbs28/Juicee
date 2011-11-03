# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  user_name          :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  first_name         :string(255)
#  last_name          :string(255)
#  encrypted_password :string(255)
#  salt               :string(255)
#

require 'spec_helper'

describe User do

    before(:each) do
        @attr = {
            :first_name => "John",
            :last_name => "Doe",
            :user_name => "jdoe",
            :email => "jdoe@gmail.com",
            :password => "foobar1",
            :password_confirmation => "foobar1"
        }
    end

    it "should create a new instance given valid attributes" do
        User.create!(@attr)
    end



    ##########################
    # Model: User
    # Test: test to require a first name
    #
    ##########################
    it "should require a first name" do
        no_last_name_user = User.new(@attr.merge(:first_name => ""))
        no_last_name_user.should_not be_valid
    end

    ##########################
    # Model: User
    # Test: test to require a first name
    #
    ##########################
    it "should require a last name" do
        no_last_name_user = User.new(@attr.merge(:last_name => ""))
        no_last_name_user.should_not be_valid
    end

    ##########################
    # Model: User
    # Test: test to require an email
    #
    ##########################
    it "should require an email" do
        no_email = User.new(@attr.merge(:email => ""))
        no_email.should_not be_valid
    end

    ##########################
    # Model: User
    # Test: test to require a user name
    #
    ##########################
    it "should require an user name" do
        no_user_name = User.new(@attr.merge(:user_name => ""))
        no_user_name.should_not be_valid
    end

    ##########################
    # Model: User
    # Test: test to reject first names longer than 75 characters
    #
    ##########################
    it "should reject first names that are too long" do
        long_first_name = "a" * 76
        long_first_name_user = User.new(@attr.merge(:first_name => long_first_name))
        long_first_name_user.should_not be_valid
    end

    ##########################
    # Model: User
    # Test: test to reject last names that are longer than 75 characters
    #
    ##########################
    it "should reject last names that are too long" do
        long_last_name = "a" * 76
        long_last_name_user = User.new(@attr.merge(:last_name => long_last_name))
        long_last_name_user.should_not be_valid
    end

    ##########################
    # Model: User
    # Test: test to make sure the email address is in a valid email format
    #
    ##########################
    it "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = User.new(@attr.merge(:email => address))
          valid_email_user.should be_valid
        end
    end

    ##########################
    # Model: User
    # Test: test to reject all invalid addresses
    #
    ##########################
    it "should reject invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = User.new(@attr.merge(:email => address))
          invalid_email_user.should_not be_valid
        end
    end

    ##########################
    # Model: User
    # Test: test to reject duplicate email addresses
    #
    ##########################
    it "should reject duplicate email addresses" do
        # Put a user with given email address into the database.
        User.create!(@attr)
        user_with_duplicate_email = User.new(@attr)
        user_with_duplicate_email.should_not be_valid
    end

    ##########################
    # Model: User
    # Test: test to make sure user names are unique
    #
    ##########################
    it "should reject duplicate user name" do
        User.create!(@attr)
        user_with_duplicate_user_name = User.new(@attr)
        user_with_duplicate_user_name.should_not be_valid
    end

    describe "password validations" do


        ##########################
        # Model: User
        # Test: test to require a password in the password field
        #
        ##########################
        it "should require a password" do
          User.new(@attr.merge(:password => "", :password_confirmation => "")).
            should_not be_valid
        end

        ##########################
        # Model: User
        # Test: test to make sure that the password matches with its password
        #       confirmation
        #
        ##########################
        it "should require a matching password confirmation" do
          User.new(@attr.merge(:password_confirmation => "invalid")).
            should_not be_valid
        end

        ##########################
        # Model: User
        # Test: test to make sure that passwords less than 7 characters are not accepted
        #
        ##########################
        it "should reject short passwords" do
          short = "a" * 6
          hash = @attr.merge(:password => short, :password_confirmation => short)
          User.new(hash).should_not be_valid
        end

        ##########################
        # Model: User
        # Test: test to make sure that passwords longer than 40 characters are not accepted
        #
        ##########################
        it "should reject long passwords" do
          long = "a" * 41
          hash = @attr.merge(:password => long, :password_confirmation => long)
          User.new(hash).should_not be_valid
        end
    end

    describe "password encryption" do

        before(:each) do
          @user = User.create!(@attr)
        end

        ##########################
        # Model: User
        # Test: test to make sure there is an encrypted password attribute
        #
        ##########################
        it "should have an encrypted password attribute" do
          @user.should respond_to(:encrypted_password)
        end

        ##########################
        # Model: User
        # Test: test to make sure the encrypted password is set
        #
        ##########################
        it "should set the encrypted password" do
          @user.encrypted_password.should_not be_blank
        end

        ##########################
        # Model: User
        # Test: tests for the user's submitted password
        #
        ##########################
        describe "has_password? method" do

          ##########################
          # Model: User
          # Test: test to see if the submitted password matches the encrypted
          #       password
          #
          ##########################
          it "should be true if the passwords match" do
            @user.has_password?(@attr[:password]).should be_true
          end

          ##########################
          # Model: User
          # Test: test to make sure that the return value is false if the
          #       submitted password does not match the encrypted password
          #
          ##########################
          it "should be false if the passwords don't match" do
            @user.has_password?("invalid").should be_false
          end
        end

        ##########################
        # Model: User
        # Test: tests for authentication
        #
        ##########################
        describe "authenticate method" do

            ##########################
            # Model: User
            # Test: test to see if the return value is nil for user/pass mismatch
            #
            ##########################
            it "should return nil on username/password mismatch" do
              wrong_password_user = User.authenticate(@attr[:user_name], "wrongpass")
            wrong_password_user.should be_nil
          end

          ##########################
          # Model: User
          # Test: test to see if the return value is nil for a username belonging to no
          #       user
          #
          ##########################
          it "should return nil for a username with no user" do
              nonexistent_user = User.authenticate("barfoo0101", @attr[:password])
            nonexistent_user.should be_nil
          end

          ##########################
          # Model: User
          # Test: test to see if the user is returned when user/pass are matches
          #
          ##########################
          it "should return the user on username/password match" do
              matching_user = User.authenticate(@attr[:user_name], @attr[:password])
            matching_user.should == @user
          end
        end
    end

    ##########################
    # Model: User
    # Test: tests for bookmark association to the user
    #
    ##########################
    describe "bookmarks associations" do

      before(:each) do
        @user = User.create(@attr)
         @mp1 = Factory(:bookmark, :user => @user, :created_at => 1.day.ago)
         @mp2 = Factory(:bookmark, :user => @user, :created_at => 1.hour.ago)
      end

      it "should have a bookmarks attribute" do
        @user.should respond_to(:bookmarks)
      end

      ##########################
      # Model: User
      # Test: test to make sure bookmarks are ordered in the correct possition by descending
      #       order by date created, 'created_at'
      #
      ##########################
      it "should have the right bookmarks in the right order" do
        @user.bookmarks.should == [@mp2, @mp1]
      end

      ##########################
      # Model: User
      # Test: test to make sure bookmarks are destroyed accordingly that are associated
      #       with the current user
      #
      ##########################
      it "should destroy associated bookmarks" do
        @user.destroy
        [@mp1, @mp2].each do |bookmark|
            Bookmark.find_by_id(bookmark.id).should be_nil
        end
      end

    end
end
