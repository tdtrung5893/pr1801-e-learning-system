class LessonsController < ApplicationController
  before_action :logged_in_user, only: :show
  before_action only: :index do
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
  end

  private

  def lesson_params
    params.require(:lesson).permit :category_id, :name
  end
end
