require 'digest/sha1'

class User < ActiveRecord::Base

  attr_protected :hashed_password
  validates_presence_of :email, :password, :on => :create

  def self.authenticate(email, password)
    user = User.find_by_email(email)
 
    if user and user.password == hashed_password(password)
      user
    else
      nil
    end
  end

  def self.hashed_password(password)
    Digest::SHA1.hexdigest(sprintf("%s%08d", password, 1234567890))
  end
end
