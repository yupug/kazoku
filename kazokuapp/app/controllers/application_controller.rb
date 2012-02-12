#coding: utf-8
class ApplicationController < ActionController::Base
  # ログイン認証用のフィルタ
  before_filter :check_logined

  protect_from_forgery

  # 認証状況を確認するフィルタの定義
  def check_logined
    if session[:user_id]
      begin
        @current_user = User.find_by_id(session[:user_id])
        @kazoku_users = User.where("kazoku_id = ? and id != ?", 
          @current_user.kazoku_id, @current_user.id) || []

      rescue ActiveRecord::RecordNotFound
        logger.error "セッションの情報(" + session[:user_id] + ")は user_infos には存在しません。"
        reset_session
      end
    end

    unless @current_user
      flash[:referer] = request.fullpath
      redirect_to :controller => 'login', :action => 'index'
    end
  end

end
