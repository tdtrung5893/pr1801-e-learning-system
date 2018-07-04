class CategoriesController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :admin_user, only: [:new, :create]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
  end

  def create
    category = Category.new category_params
    if category.save
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
