require 'spec_helper'

describe "bookmarks/show.html.erb" do
  before(:each) do
    @bookmark = assign(:bookmark, stub_model(Bookmark,
      :url => "Url",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
