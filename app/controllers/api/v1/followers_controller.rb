class Api::V1::FollowersController < ApplicationController
  def create
    unless current_user.user_following.exists?(params[:user_id])
      @follower = Follower.create(user_id: params[:user_id], follower_user: current_user)

      if @follower.save
        render json: { status: 'Success', message: 'You have successfully followed' }, status: 201
      else
        render json: { status: 'Error', message: @follower.errors.full_messages }, status: 422
      end

    else
      @follow = Follower.where(user_id: params[:user_id], follower_user_id: current_user.id)

      @follow.destroy
      render json: { message: 'Unfollowed' }
    end
  end

  private

  def follower_params
    params.require(:follower).permit(:user_id)
  end
end
