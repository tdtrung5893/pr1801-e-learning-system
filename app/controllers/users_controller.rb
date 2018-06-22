class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.select(:id, :username, :email).paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("register_success")
      redirect_to @user
    else
      flash[:success] = t("register_failed")
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update

  end

  def destroy

  end

  private
  def set_user
    @user = User.find_by id: params[:id]
    redirect_to root_url if @user.nil?
  end

  def user_params
    params.require(:user).permit :username, :email, :password, :password_confirmation
  end
end
