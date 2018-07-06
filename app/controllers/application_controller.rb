class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :load_categories

  private

  def load_categories
    @categories = Category.load_category
  end
end
