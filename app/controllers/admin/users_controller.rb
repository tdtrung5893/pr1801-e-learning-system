class Admin::UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :get_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.by_user(params[:search]).paginate page: params[:page],
      per_page: Settings.users.page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "register_success"
      redirect_to @user
    else
      flash[:success] = t "register_failed"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if !@user.role?
      @user.destroy
      flash[:success] = t "user_deleted"
    else
      redirect_to admin_users_url
      flash[:danger] = t "cant_delete"
    end
  end

  private

  def user_params
    params.require(:user).permit :avatar, :username, :email, :password,
      :password_confirmation
  end

  def get_user
    @user = User.find_by id: params[:id]
    redirect_to root_url if @user.nil?
  end

  def correct_user
    redirect_to root_url unless current_user? @user
  end
end
