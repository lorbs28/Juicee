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
  attr_accessible :url, :name

  belongs_to :user

  validates :url, :presence => true, :length => { :minimum => 10 }
  validates :name, :presence => true, :length => { :maximum => 100}
  validates :user_id, :presence => true

  default_scope :order => 'bookmarks.created_at DESC'
end
