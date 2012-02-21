#coding: utf-8

class Photo < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user
  belongs_to :content
  has_many :comments

  include Rails.application.routes.url_helpers
  mount_uploader :image, ImageUploader
  
  after_create :after_create_callback
  def after_create_callback
    timeline = Timeline.new
    timeline.create_by_upload_photo(self) 
  end
  
  def comment_count
    @comment_count ||= comments.length
  end

  def to_jq_upload
      {
        "name" => read_attribute(:image),
        "size" => image.size,
        "url" => image.thumb.url, #image.url,
        "thumbnail_url" => image.thumb.url,
        "delete_url" => '/photos/delete/',
        "delete_type" => "DELETE" 
      }
  end

end
