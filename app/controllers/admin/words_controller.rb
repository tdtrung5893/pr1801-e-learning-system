class Admin::WordsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :admin_user, except: [:index, :show]
  before_action :load_lessons, only: [:new]
  before_action only: [:index, :new, :edit, :create, :destroy] do
    get_category params[:category_id]
  end
  before_action only: [:index, :new, :create] do
    get_lesson params[:lesson_id]
  end

  def index
    @words = @lesson.words.order(name: :asc).paginate page: params[:page]
  end

  def show; end

  def new
    @word = Word.new
  end

  def edit; end

  def create
    @word = @lesson.words.build word_params
    if @word.save
      flash[:success] = t "word_added"
      redirect_to admin_category_lesson_words_url
    else
      flash[:danger] = t "add_failed"
      render :new
    end
  end

  private

  def word_params
    params.require(:word).permit :name, :description, :question, :lesson_id
  end
end
