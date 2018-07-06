class LessonsController < ApplicationController
  before_action :get_category, only: :index

  def index
    @lessons = @category.lessons
  end

  private

  def get_category
    redirect_to root_url unless @category = Category.find_by(id: params[:category_id])
  end
end
