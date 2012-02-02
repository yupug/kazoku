require 'net/pop'
require 'tmail'
require 'nkf'

class Mail < ActiveRecord::Base
  def self.poll_mailgun
    logger.debug("Start fetching emails from mailgun")  
    config = Rails.application.config
  
    pop =  Net::POP3.new( 'pop.mailgun.org' )
    pop.start( config.mailgun_email , config.mailgun_password )

    if  pop.mails.empty? then
      logger.debug("No mail")
    else
      pop.each_mail do |m|
        email = TMail::Mail.parse(m.pop)
        if email.has_attachments?
          email.attachments.each do |attachment|
              mail = Mail.new(
                :from => email.from.first,
                :to => email.to.first,
                :title => email.subject,
                :attachment => attachment.read
              )
              mail.save
              #m.delete
          end
        end
      end
      logger.debug("Some mails")
    end
    pop.finish
  end
end
