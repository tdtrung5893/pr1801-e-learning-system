class UserWordsController < ApplicationController
  before_action only: :create do
    get_lesson params[:user_word][:lesson_id]
  end

  def index; end

  def create
    ActiveRecord::Base.transaction do
      UserLesson.create user: current_user, lesson_id: params[:user_word][:lesson_id], status: 1
      word_data = [user_word_params.keys, user_word_params.values].transpose
      word_data.each do |key, value|
        UserWord.create user: current_user, word_id: key, answer_id: value
      end
      redirect_to category_lessons_url(@lesson)
      flash[:success] = t "exam_complete"
    end
    rescue
      redirect_to root_url
      flash[:danger] = t "exam_error"
  end

  private

  def user_word_params
    params.require :user_word
  end
end
