# == Schema Information
#
# Table name: bookmarks
#
#  id         :integer         not null, primary key
#  url        :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Bookmark < ActiveRecord::Base
  validates :url, :length => { :minimum => 10 }
  validates :name, :length => { :maximum => 100}
end
