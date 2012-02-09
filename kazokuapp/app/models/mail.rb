require 'net/pop'
require 'tmail'
require 'RMagick'

class Mail < ActiveRecord::Base
  def self.poll_mailgun
    logger.debug("Start fetching emails from mailgun")  
    config = Rails.application.config
  
    pop =  Net::POP3.new( 'pop.mailgun.org' )
    pop.start( config.mailgun_email , config.mailgun_password )
    
    if  pop.mails.empty? then
      logger.debug("No mail")
    else
      # fetch user's receive_emails      
      pop.each_mail do |m|
        email = TMail::Mail.parse(m.pop)        

        unless @user = User.find_by_receive_email(email.to.first) then
          # mail will be deleted when 'to' address is invalid
          m.delete
        end
        
        if email.has_attachments?
          email.attachments.each do |attachment|
            image =  Magick::Image.from_blob(attachment.read).first
            scale = (image.columns > image.rows) ? "960x720" : "720x960"
            resized = image.change_geometry(scale) do |cols,rows,img|
              img.resize(cols, rows)
            end

            begin
              @content = Content.new(
                :kazoku => @user.kazoku,
                :user => @user,
                :data => resized.to_blob
              )
              @content.save!
              
              @photo = Photo.new(
                :kazoku => @user.kazoku,
                :user => @user,
                :content => @content,
                :title => email.subject,
                :mime_type => resized.mime_type
              )
              @photo.save!

              #m.delete
              
            rescue Exception => e
              logger.error(e)
            end
          end
        else
          #mail without any attachements will be deleted 
          m.delete
        end
      end
    end
    pop.finish
  end
end
