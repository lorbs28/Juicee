require 'spec_helper'

describe Bookmark do

  before(:each) do
    @user = Factory(:user)
    @attr = {
                :url => "www.yahoo.com",
                :name => "yahoo.com",
            }
  end

  it "should create a new instance given valid attributes" do
    @user.bookmarks.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @bookmark = @user.bookmarks.create(@attr)
    end

    it "should have a user attribute" do
      @bookmark.should respond_to(:user)
    end

    it "should have the right associated user" do
      @bookmark.user_id.should == @user.id
      @bookmark.user.should == @user
    end
  end

  describe "validations" do

    it "should require a user id" do
      Bookmark.new(@attr).should_not be_valid
    end

    it "should require nonblank url" do
      @user.bookmarks.build(:url => "  ").should_not be_valid
    end

    it "should require nonblank name" do
        @user.bookmarks.build(:name => "  ").should_not be_valid
    end

    it "should reject long site name" do
        @user.bookmarks.build(:name => "a" * 101).should_not be_valid
    end
  end

end

