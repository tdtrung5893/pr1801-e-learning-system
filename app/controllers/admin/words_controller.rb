class Admin::WordsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :admin_user, except: [:index, :show]
  before_action :load_lessons, only: [:new, :create, :edit, :update]
  before_action only: [:index, :new, :edit, :create] do
    get_category params[:category_id]
  end
  before_action only: [:index, :new, :edit, :create, :update] do
    get_lesson params[:lesson_id]
  end
  before_action :get_word, only: [:edit, :update, :destroy]

  def index
    @words = @lesson.words.search_prefix(params[:prefix]).order_name_asc.
      paginate page: params[:page]
  end

  def show; end

  def new
    @lessons = @category.lessons
    @word = Word.new
    Settings.words.answer_number.times.each {@word.answers.build}
  end

  def edit; end

  def create
    @word = @lesson.words.build word_params
    if @word.save
      flash[:success] = t"word_added"
      redirect_to admin_category_lesson_words_url
    else
      flash[:danger] = t"add_failed"
      render :new
    end
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t"word_updated"
      redirect_to admin_category_lesson_words_url
    else
      flash[:danger] = t"update_failed"
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t"word_deleted"
      redirect_to admin_category_lesson_words_url
    else
      flash[:danger] = t"delete_word_failed"
      render :index
    end
  end

  private

  def word_params
    params.require(:word).permit :name, :description, :question, :lesson_id,
      answers_attributes: [:id, :content, :correctness]
  end

  def get_word
    redirect_to root_url unless @word = Word.find_by(id: params[:id])
  end
end
