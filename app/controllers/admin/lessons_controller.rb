class Admin::LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :get_category, only: [:index, :new, :create, :edit]
  before_action :get_lesson, only: [:edit, :update, :destroy]

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
      redirect_to admin_category_lessons_url
    else
      flash[:danger] = t "lesson_create_fail"
      redirect_to new_admin_category_lesson_url
    end
  end

  def show
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "update_lesson"
      redirect_to admin_category_lessons_url
    else
      flash[:danger] = t "update_lesson_failed"
      render :edit
    end
  end

  def destroy
    if @lesson.destroy
      flash[:success] = t "lesson_deleted"
      redirect_to admin_category_lessons_url
    else
      flash[:danger] = t "delete_lesson_failed"
      render :index
    end
  end

  private

  def get_lesson
    redirect_to root_url unless @lesson = Lesson.find_by(id: params[:id])
  end

  def get_category
    redirect_to root_url unless @category = Category.find_by(id: params[:category_id])
  end

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end
end
