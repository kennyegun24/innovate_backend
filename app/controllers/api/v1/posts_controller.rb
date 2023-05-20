class Api::V1::PostsController < ApplicationController
    skip_before_action :authenticate_request, only: %i[index show]
    def create
        @post = current_user.posts.create(post_params)

        if @post.save
            render json: {status: 'Successful', message: 'Post created'}, status: 201
        else
            render json: {status: 'Failed', message: 'Failed to create post'}, status: 422
        end
    end

    def index
        @posts = Post.all
        render json: {status: 'Successful', message: 'All Posts', data: @posts}, status: 200
    end

    def show
        @post = Post.find(params[:id])
        render json: {status: 'Successful', message: 'Post', data: @post}, status: 200
    end

    def post_params
        params.require(:post).permit(:text, :image)
    end
end
