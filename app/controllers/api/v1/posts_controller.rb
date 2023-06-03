class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]
  def create
        @post = current_user.posts.create(post_params)

        if @post.save
            render json: {status: 'Successful', message: 'Post created'}, status: 201
        else
            render json: {status: 'Failed', message: @post.errors.full_messages}, status: 422
        end
  end

  def index
      @posts = Post.all.order(created_at: :DESC)
      render json: {status: 'Successful', message: 'All Posts', data: @posts}, status: 200
  end
  
  def show
      @post = Post.find(params[:id])
      render json: {status: 'Successful', message: 'Post', data: @post}, status: 200
  end

  def authenticated_index
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

  def authenticated_show
      @post = Post.find(params[:id])
      @isLiked = @post.post_likes.pluck(:user_id).include?(current_user.id)

      one_post = {
          **@post.attributes.symbolize_keys,
          liked: @isLiked
      }
      # @post.liked = @isLiked
      render json: {status: 'Successful', message: 'Post', data: one_post}, status: 200
  end

  def current_user_posts
    @posts = current_user.posts.includes(:post_likes).order(created_at: :desc)
    # @liked = current_user.post_likes.select(:post_id).pluck(:post_id)

    # @all_posts = @posts.map do |post|
    #   {
    #     **post.attributes.symbolize_keys,
    #     liked: @liked.include?(post.id)
    #   }
    # end

    render json: {message: 'Curren user posts', status: 'Successful', data: @posts}, status: 200
  end

  def post_params
      params.require(:post).permit(:text, :image)
  end
end
