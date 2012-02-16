#coding: utf-8
require 'mail'
require 'RMagick'

class MailgunHandler < ActiveRecord::Base          
  def self.poll 
    @users = User.where("users.receive_email IS NOT NULL");

    @users.each do |user|
      logger.debug("Fetch mails of " + user.receive_email)

      Mail.defaults do
        retriever_method :pop3, { 
           :address             => "pop.mailgun.org",
           :port                => 110,
           :user_name           => user.receive_email,
           :password            => 'nadesico',
           :enable_ssl          => false }
      end

      Mail.all(:delete_after_find => false).each do |email|
        begin
          if email.has_attachments? && !email.attachments.blank? then
            email.attachments.each do |attachment|
              logger.debug("Mail (" + email.subject + ") proccessing...")

              image =  Magick::Image.from_blob(attachment.read).first
              scale ||= (image.columns > image.rows) ? "960x720" : "720x960"
              resized = image.change_geometry(scale) do |cols,rows,img|
                img.resize(cols, rows)
              end
              
              begin                
                @content = Content.new(
                  :kazoku => user.kazoku,
                  :user => user,
                  :data => resized.to_blob
                )
                @content.save!
                    
                @photo = Photo.new(
                  :kazoku => user.kazoku,
                  :user => user,
                  :content => @content,
                  :title => email.subject,
                  :mime_type => attachment.mime_type
                )
                @photo.save!   
              rescue Exception => e
                raise e
              end
            end
          end
        rescue => ignore
          logger.error(ignore.to_s)
        end
      end
    end
  end
end
