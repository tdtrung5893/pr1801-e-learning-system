class LessonsController < ApplicationController
  before_action :load_categories, only: [:index, :new, :create]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_category, only: [:index, :new, :create]

  def index
    @lessons = @category.lessons
  end

  def new
    @lesson = Lesson.new
  end

  def create
    @lesson = @category.lessons.build lesson_params
    if @lesson.save
      flash[:success] = t "lesson_create"
      redirect_to category_lessons_url
    else
      flash[:danger] = t "lesson_create_fail"
      redirect_to new_category_lesson_url
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

  def set_category
    root_url unless @category = Category.find_by(id: params[:category_id])
  end

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end

  def load_categories
    @categories = Category.load_category
  end

  def admin_user
    redirect_to root_url unless current_user.role?
  end
end
