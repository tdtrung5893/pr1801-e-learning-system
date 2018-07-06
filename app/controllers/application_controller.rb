class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  before_action :load_category

  private

  def load_category
    @categories = Category.load_data_category
  end
end
