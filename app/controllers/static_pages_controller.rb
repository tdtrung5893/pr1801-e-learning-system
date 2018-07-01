class StaticPagesController < ApplicationController
  def home
    @categories = Category.load_category
  end

  def about
  end

  def help
  end
end
