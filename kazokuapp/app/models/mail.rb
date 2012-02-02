require 'net/pop'
class Mail < ActiveRecord::Base
  def self.fetchEmailFromMailgun
    logger.debug("Start fetching emails from mailgun")
    pop =  Net::POP3.new( 'pop.mailgun.org' )
    pop.start( 'post-images-dev@kazoku.mailgun.org' , 'xxxxxx' )
    if  pop.mails.empty? then
      logger.debug("No mail")
    else
      logger.debug("Some mails")
    end
    pop.finish
  end
end
