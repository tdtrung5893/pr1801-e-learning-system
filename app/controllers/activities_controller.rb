class ActivitiesController < ApplicationController
  before_action :logged_in_user

  def index
    @activities = PublicActivity::Activity.order(created_at: :desc)
      .where(owner_id: current_user.following_ids, owner_type: User.name)
      .paginate page: params[:page]
  end
end
