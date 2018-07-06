class CategoriesController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]

  def index
    @categories = Category.all
  end
end
