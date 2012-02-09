class Kazoku < ActiveRecord::Base
  has_many :users
  has_many :photos
  has_many :comments
end
