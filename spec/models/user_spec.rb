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
end
