#coding: utf-8
class MailsController < ApplicationController
  skip_before_filter :check_logined 

  def index
    MailgunHandler.poll
    redirect_to :controller => 'photos', :action => 'index'
  end
end
