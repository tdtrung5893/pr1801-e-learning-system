class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :admin_user
  before_action :get_category, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "category_created"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "create_failed"
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category_updated"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category_update_failed"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category_deleted"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "category_destroy_failed"
      render :index
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :description
  end

  def get_category
    redirect_to admin_categories_path unless @category = Category.find_by(id: params[:id])
  end
end
