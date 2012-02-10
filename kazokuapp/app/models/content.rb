#coding: utf-8

class Content < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user

end
