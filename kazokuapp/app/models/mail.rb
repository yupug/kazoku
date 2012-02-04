require 'net/pop'
require 'tmail'
#require 'nkf'
require 'rmagick'

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
      # generate hashtable { email => user_id }
      email_user_id_hashtbl = {}
      @users = User.find(:all, :conditions=>['LENGTH(receive_email) > 0'])
      @users.each do |user|
        email_user_id_hashtbl[user.receive_email] = user.id
      end
      logger.debug(email_user_id_hashtbl)
      
      pop.each_mail do |m|
        email = TMail::Mail.parse(m.pop)        

        unless user_id = email_user_id_hashtbl.has_key?(email.to.first) then
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
              @photo = Photo.new(
                :user_id => user_id,
                :title => email.subject,
                :content => resized.to_blob
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
