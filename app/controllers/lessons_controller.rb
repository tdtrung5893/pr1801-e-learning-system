class LessonsController < ApplicationController
  before_action :load_categories, only: [:new, :create]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new lesson_params
    if @lesson.save
      flash[:success] = t "lesson_create"
      redirect_to @lesson
    else
      flash[:danger] = t "lesson_create_fail"
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

  def load_categories
    @categories = Category.load_category
  end

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end
end
