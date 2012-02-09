require 'RMagick'

class Content < ActiveRecord::Base
  belongs_to :kazoku
  belongs_to :user

  def self.thumbnail(binary, scale)
    image =  Magick::Image.from_blob(binary).first

    scale ||= (image.columns > image.rows) ? "960x720" : "720x960"
    resized = image.change_geometry(scale) do |cols,rows,img|
      img.resize(cols, rows)
    end

    return resized.to_blob
     
  end
end
