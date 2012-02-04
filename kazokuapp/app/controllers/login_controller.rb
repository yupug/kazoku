class LoginController < ApplicationController
  skip_before_filter :check_logined 

  # ログイン
  def login
    email = params[:email]
    password = params[:password]
    
    logger.debug("email:" + email)
    logger.debug("password:" + password)
    
    user = User.authenticate(email, password)

    if user then
      session[:user_id] = user.id
      redirect_to :controller => 'users', :action => 'index'
      flash[:notice] = "Logged in successfully"
    else
      session[:user_id] = nil
      redirect_to :controller => 'login', :action => 'index'
      flash[:warning] = 'ログイン失敗'
      flash[:email] = email
    end
  end

  # ログアウト
  def logout
    session[:user_id] = nil
    redirect_to :controller => 'login', :action => 'index'
  end
end
