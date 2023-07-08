class Api::V1::Auth::FollowsController < ApplicationController
  def create
    unless current_user.user_following.exists?(params[:id])
      @follower = Follower.new(user_id: params[:id], follower_user: current_user)

      if @follower.save
        render json: { status: 'Success', message: 'You have successfully followed' }, status: 201
      else
        render json: { status: 'Error', message: @follower.errors.full_messages }, status: 422
      end

    else
      @follow = Follower.find_by(user_id: params[:id], follower_user: current_user)

      if @follow.destroy
        render json: { message: 'Unfollowed' }
      else
        render json: { status: 'Error', message: @follow.errors.full_messages }, status: 422
      end
    end
  end

  def index #logged in user followers
    @followers = current_user.user_followers

    render json: {status: 'Success', data: @followers}, status:200
  end

  private

  def follower_params
    params.require(:follower).permit(:user_id)
  end
end
