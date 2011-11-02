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

class User < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :user_name, :email

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :first_name, :presence => true,
                           :length => { :maximum => 75 }
    validates :last_name, :presence => true,
                          :length => { :maximum => 75 }
    validates :email, :presence => true,
                      :format   => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }
    validates :user_name, :presence => true


end
