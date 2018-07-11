class UserWordsController < ApplicationController
  def index; end

  def create
    ActiveRecord::Base.transaction do
      word_data = [user_word_params.keys, user_word_params.values].transpose.to_h
      word_data.each do |key, value|
        UserWord.create user: current_user, word_id: key, answer_id: value
      end
      redirect_to root_url
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
