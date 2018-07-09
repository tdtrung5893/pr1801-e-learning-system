class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :load_categories

  private

  def load_categories
    @categories = Category.load_category
  end

  def load_lessons
    @lessons = Lesson.load_lesson
  end

  def get_category category_id
    redirect_to root_url unless @category = Category.find_by(id: category_id)
  end

  def get_lesson lesson_id
    redirect_to root_url unless @lesson = Lesson.find_by(id: lesson_id)
  end
end
