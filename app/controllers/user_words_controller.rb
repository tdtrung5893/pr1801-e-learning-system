class UserWordsController < ApplicationController
  before_action only: [:create, :update] do
    get_lesson params[:user_word][:lesson_id]
  end

  def index; end

  def create
    @words = @lesson.words
    ActiveRecord::Base.transaction do
      user_lesson = UserLesson.create user: current_user,
        lesson_id: params[:user_word][:lesson_id], status: false
      word_data = [user_word_params.keys, user_word_params.values].transpose
      word_data.shift
      @words.each do |word|
        found = false
        word_data.each do |key, value|
          if word.id == key.to_i
            found = true
            UserWord.create user: current_user, word_id: key, answer_id: value
            break
          end
        end
        if !found
          UserWord.create user: current_user, word_id: word.id
        end
      end
      update_user_lesson user_lesson
      redirect_to category_lessons_url @lesson
      flash[:success] = t "exam_complete"
    end
    rescue
      redirect_to root_url
      flash[:danger] = t "exam_error"
  end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      word_data = [user_word_params.keys, user_word_params.values].transpose
      word_data.shift
      word_data.each do |key, value|
        user_word = UserWord.where(user_id: current_user.id, word_id: key).first
        user_word.update_attributes answer_id: value
      end
      user_lesson = UserLesson.where(user_id: current_user.id, lesson_id: @lesson.id).first
      update_user_lesson user_lesson
      redirect_to category_lessons_url @lesson
      flash[:success] = t "exam_complete"
    end
    rescue
      redirect_to root_url
      flash[:danger] = t "exam_error"
  end

  private

  def update_user_lesson user_lesson
    @user_word_result = current_user.user_words.by_word(@lesson)
    @word_correct = @user_word_result.count { |item| item.status }
    if @word_correct == @lesson.words.size
      user_lesson.update_attributes status: true
    end
  end

  def user_word_params
    params.require :user_word
  end
end
