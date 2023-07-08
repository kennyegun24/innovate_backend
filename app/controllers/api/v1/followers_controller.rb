class Api::V1::FollowersController < ApplicationController
    skip_before_action :authenticate_request, only: %i[other_user_followers]

  def other_user_followers #other user followers user/:id/followers
    # @user = Follower.where(user_id: params[:id])
    @user = User.find(params[:id]).user_followers.select(:id, :name,:header,:followers_count, :profession,:image).order(created_at: :desc)
    render json: {status: 'Success', data: @user}, status:200
  end
end
