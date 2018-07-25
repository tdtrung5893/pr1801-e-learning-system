class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    if user = User.find_by(id: params[:followed_id])
      current_user.follow user
      redirect_to user
    else
      render "users/index"
    end
  end

  def destroy
    if user = Relationship.find_by(id: params[:id]).followed
      current_user.unfollow user
      redirect_to user
    else
      render "users/index"
    end
  end
end
