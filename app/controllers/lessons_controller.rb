class LessonsController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action :get_category, only: :index
  before_action :get_lesson, only: :show
  def index
    @lessons = @category.lessons
  end

  def show
    @words = @lesson.words
  end

  private

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end

  def get_lesson
    redirect_to root_url unless @lesson = Lesson.find_by(id: params[:id])
  end

  def get_category
    redirect_to root_url unless @category = Category.find_by(id: params[:category_id])
  end
end
