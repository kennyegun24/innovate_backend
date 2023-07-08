class Api::V1::Auth::PostsController < ApplicationController

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      render json: {status: 'Successful', message: 'Post created'}, status: 201
    else
      render json: {status: 'Failed', message: @post.errors.full_messages}, status: 422
    end
  end

  # Lists of posts to be displayed when there iis an authenticated user
  def index
    @posts = Post.all.order(created_at: :DESC)

    @liked = current_user.post_likes.pluck(:post_id)

    @all_posts = @posts.map do |post|
      {
        **post.attributes.symbolize_keys,
        liked: @liked.include?(post.id)
      }
    end

    render json: {status: 'Successful', message: 'All Posts', data: @all_posts}, status: 200

  end

  # Post details to be displayed when there  an authenticated user
  def show
    @post = Post.find(params[:id])
    @isLiked = @post.post_likes.pluck(:user_id).include?(current_user.id)

    @isFollowed = @post.author.followers.pluck(:follower_user_id).include?(current_user.id)
    one_post = {
      **@post.attributes.symbolize_keys,
      liked: @isLiked,
      isFollowed: @isFollowed
    }
    render json: {status: 'Successful', message: 'Post', data: one_post}, status: 200
  end

  # All posts for the authenticated user
  def current_user_posts
    @posts = current_user.posts.includes(:post_likes).order(created_at: :desc)
    render json: {message: 'Curren user posts', status: 'Successful', data: @posts}, status: 200
  end

  # All posts for other user
  def other_users_posts
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(created_at: :DESC)
    render json: {message: 'User posts', status: 'Successful', data: @posts, id: @user.id}, status: 200
  end

  def destroy
    @post = current_user.posts.destroy(params[:id])
    render json: {message: 'Post Deleted', status: 'Successful'}, status: 200
  end

  def post_params
    params.require(:post).permit(:text, :image)
  end
end
