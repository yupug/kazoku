class Photo < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user
  belongs_to :content
  has_many :comments
end
