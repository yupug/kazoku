class Timeline < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user
end
