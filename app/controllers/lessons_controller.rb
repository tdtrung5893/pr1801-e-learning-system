class LessonsController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action only: [:index, :show] do
    get_category params[:category_id]
  end
  before_action only: [:edit, :show, :get_exam] do
    get_lesson params[:id]
  end

  def edit
    get_user_lesson @lesson
    get_exam
  end

  def index
    @lessons = @category.lessons
    if logged_in?
      @user_lesson = current_user.user_lessons
    end
  end

  def show
    get_user_lesson @lesson
    @user_lesson = current_user.user_lessons.by_lesson(@lesson).first
    get_exam
  end

  private

  def get_user_lesson lesson
    @user_lesson = current_user.user_lessons.by_lesson(lesson).first
  end

  def get_exam
    @words = @lesson.words
    @user_word_result = current_user.user_words.by_word(@lesson)
    @word_correct_result = @user_word_result.count { |item| item.status }
    @user_words = {}
    @words.each do |word|
      found = false
      @user_word_result.each do |user_word|
        if word.id == user_word.word_id
          found = true
          @user_words[user_word.word_id] = {answer_id: user_word.answer_id, status: user_word.status}
          break
        end
      end
      if !found
        @user_words[word.id] = {answer_id: nil, status: nil}
      end
    end
  end

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end
end
