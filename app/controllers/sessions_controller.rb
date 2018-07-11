class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = t "login_success"
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t "login_failed"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t "logout_success"
    redirect_to root_url
  end
end
