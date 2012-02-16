class Comment < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user
  belongs_to :photo

  after_create :after_create_callback
  def after_create_callback
    timeline = Timeline.new
    timeline.create_by_comment(self) 
  end
end
