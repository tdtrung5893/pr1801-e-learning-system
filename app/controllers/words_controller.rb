class WordsController < ApplicationController
  before_action :load_user_words, only: :index
  before_action only: :index do
    get_category params[:category_id]
    get_lesson params[:lesson_id]
  end

  def index
    if logged_in?
      search(current_user.id)
    else
      search(params[:user_id])
    end
  end

  def show; end
end
