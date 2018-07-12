class WordsController < ApplicationController
  before_action only: :index do
    get_category params[:category_id]
    get_lesson params[:lesson_id]
  end

  def index
    @words = @lesson.words.search_prefix(params[:prefix]).order_name_asc.
      paginate page: params[:page]
  end

  def show; end
end
