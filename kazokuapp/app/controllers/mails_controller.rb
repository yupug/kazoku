#coding: utf-8
class MailsController < ApplicationController
  skip_before_filter :check_logined 

  # ログイン
  def index
    Mail.poll_mailgun
    redirect_to :controller => 'photos', :action => 'index'
  end
end
