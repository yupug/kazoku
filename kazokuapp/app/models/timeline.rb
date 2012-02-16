#coding: utf-8

class Timeline < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user

  def create_by_comment(comment)
    
    self.kazoku_id = comment.kazoku_id
    self.user_id = comment.user_id
    self.action = "comment_photo"
    self.object1 = comment.id
    self.object2 = comment.comment
    self.object3 = comment.photo_id
    self.object4 = comment.photo.user_id
    self.object5 = comment.photo.user.name
    self.object6 = comment.photo.title
    self.object7 = comment.photo.mime_type
    self.object8 = comment.photo.content_id
    
    return self.save
  end

  def create_by_login(user)
    
    self.kazoku_id = user.kazoku_id
    self.user_id = user.id
    self.action = "login"

    return self.save
  end

  def create_by_upload_photo(photo)
    
    self.kazoku_id = photo.kazoku_id
    self.user_id = photo.user_id
    self.action = "upload_photo"
    self.object1 = photo.id
    self.object2 = photo.title
    self.object3 = photo.mime_type
    self.object4 = photo.content_id
    
    return self.save
  end

end
