class Api::V1::Auth::PostLikesController < ApplicationController

    def like_unlike
        @post = Post.find(params[:id])
        @likes = @post.post_likes.find_by(user: current_user.id)

        if @likes
            if @likes.destroy
                render json: {message: 'Deleted', status: 'Success'}
            else
                render json: { status: 'Failure', message: 'Failed to unlike post' }, status: 422
            end
        else
            @likes = @post.post_likes.new(user: current_user)
            @likes.user = current_user

            if @likes.save
                render json: {status: 'Successful', message: 'likes added'}, status: 201
            else
                render json: {status: 'Failure', message: @likes.errors.full_messages}, status: 422
            end
        end
    end

    def show
        @likes = PostLike.where(post_id: params[:id])
        render json: { status: 'Success', message: 'Successful', data: @likes }, status: 200
    end
end
