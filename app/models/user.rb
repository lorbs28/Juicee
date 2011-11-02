require 'digest'
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
    attr_accessor :password
    attr_accessible :first_name, :last_name, :user_name, :email, :password,
        :password_confirmation

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :first_name, :presence => true,
                           :length => { :maximum => 75 }

    validates :last_name, :presence => true,
                          :length => { :maximum => 75 }

    validates :email, :presence => true,
                      :format   => { :with => email_regex },
                      :uniqueness => { :case_sensitive => false }

    validates :user_name, :presence => true

    validates :password, :presence => true,
                         :confirmation => true,
                         :length => { :within => 7..40 }

                         before_save :encrypt_password


    # Return true if the user's password matches the submitted password.
    def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
    end

    def self.authenticate(user_name, submitted_password)
        user = find_by_user_name(user_name)
        return nil  if user.nil?
        return user if user.has_password?(submitted_password)
    end

    def self.authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user : nil
    end

    private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end


end
