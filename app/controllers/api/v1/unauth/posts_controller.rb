class Api::V1::Unauth::PostsController < ApplicationController
    skip_before_action :authenticate_request, only: %i[show index other_user_posts]
    # All posts for a non authenticated user
  def index
    page_number = params[:page] || 1
    per_page = 10
    @posts = Post.select('posts.*, (likes_count + comments_count) AS total_count ').order(created_at: :desc, total_count: :desc).paginate(page: page_number, per_page: per_page)
    render json: {status: 'Successful', message: 'All Posts', data: @posts}, status: 200
  end

  # Post details to be displayed for an un-authenticated user
  def show
    @post = Post.find(params[:id])
    render json: {status: 'Successful', message: 'Post', data: @post}, status: 200
  end

  # All posts for other user
  def other_user_posts
    page_number = params[:page] || 1
    per_page = 5
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(created_at: :DESC).paginate(page: page_number, per_page: per_page)
    render json: {message: 'User posts', status: 'Successful', data: @posts, id: @user.id}, status: 200
  end
end
