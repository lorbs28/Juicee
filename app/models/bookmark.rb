class Bookmark < ActiveRecord::Base
  validates :url, :length => { :minimum => 10 }
  validates :name, :length => { :maximum => 100}
end
