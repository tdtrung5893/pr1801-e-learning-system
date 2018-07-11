class WordsController < ApplicationController
  before_action :get_lesson

  def index
    @words = @lesson.words.order(name: :asc).paginate page: params[:page]
  end

  def show; end
end
