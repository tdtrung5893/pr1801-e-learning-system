class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def index
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category_created"
      redirect_to root_url
    else
      flash[:danger] = t "create_failed"
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :description
  end
end
