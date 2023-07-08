class Api::V1::Unauth::PostsController < ApplicationController
    skip_before_action :authenticate_request, only: %i[show index other_user_posts]
    # All posts for a non authenticated user
  def index
    @posts = Post.all.order(created_at: :DESC)
    render json: {status: 'Successful', message: 'All Posts', data: @posts}, status: 200
  end

  # Post details to be displayed for an un-authenticated user
  def show
    @post = Post.find(params[:id])
    render json: {status: 'Successful', message: 'Post', data: @post}, status: 200
  end

  # All posts for other user
  def other_user_posts
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(created_at: :DESC)
    render json: {message: 'User posts', status: 'Successful', data: @posts, id: @user.id}, status: 200
  end
end
