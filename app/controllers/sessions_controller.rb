class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash.now[:success] = t("login_success")
      redirect_to user
    else
      flash.now[:danger] = t("login_failed")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = t("logout_success")
    redirect_to root_url
  end
end
