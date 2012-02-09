#coding: utf-8
class Comment < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user
  belongs_to :photo
end
