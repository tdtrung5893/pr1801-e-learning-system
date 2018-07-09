class Admin::LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]
  before_action only: [:index, :new, :edit, :create, :destroy] do
    get_category params[:category_id]
  end
  before_action only: [:edit, :show, :update, :destroy] do
    get_lesson params[:id]
  end

  def index
    @lessons = @category.lessons
  end

  def new
    @lesson = Lesson.new
  end

  def show
    @words = @lesson.words
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

  def edit; end

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

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end
end
