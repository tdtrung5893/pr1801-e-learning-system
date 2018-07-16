class StaticPagesController < ApplicationController
  before_action :load_lessons, only: :home
  before_action :load_user_words, only: :home

  def home
    if logged_in?
      search(current_user.id)
    else
      search(params[:user_id])
    end
  end

  def about; end

  def help; end
end
