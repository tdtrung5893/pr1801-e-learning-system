class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

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

  def load_user_words
    @user_words = UserWord.load_user_word
  end

  def get_category category_id
    redirect_to root_url unless @category = Category.find_by(id: category_id)
  end

  def get_lesson lesson_id
    redirect_to root_url unless @lesson = Lesson.find_by(id: lesson_id)
  end

  def get_word word_id
    redirect_to root_url unless @word = Word.find_by(id: word_id)
  end

  def search user
    @words = Word.search_lesson(params[:lesson_id])
      .search_learned(params[:learned], user)
      .search_prefix(params[:prefix]).order_name_asc
      .paginate page: params[:page]
  end
end
