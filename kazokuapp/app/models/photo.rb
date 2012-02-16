#coding: utf-8

class Photo < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user
  belongs_to :content
  has_many :comments
  
  after_create :after_create_callback
  def after_create_callback
    timeline = Timeline.new
    timeline.create_by_upload_photo(self) 
  end
  
  def comment_count
    @comment_count ||= comments.length
  end
end
