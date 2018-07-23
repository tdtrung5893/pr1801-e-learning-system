class LessonsController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action only: [:index, :show] do
    get_category params[:category_id]
  end
  before_action only: :show do
    get_lesson params[:id]
  end

  def index
    @lessons = @category.lessons
  end

  def show
    @words = @lesson.words
    @user_lesson = current_user.user_lessons.by_lesson(@lesson).first
    @user_word_result = current_user.user_words.by_word(@lesson)
    @word_correct = @user_word_result.size
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

  private

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end
end
