class Api::V1::PostLikesController < ApplicationController
    def create
        @likes = PostLike.new(likes_params)
        @likes.user = current_user

        if @likes.save
            render json: {status: 'Successful', message: 'likes added'}, status: 201
        else
            render json: {status: 'Failure', message: @likes.errors.full_messages}, status: 422
        end
    end

    def destroy
        @likes = PostLike.find(params[:id])

        if @likes.destroy
            render json: { status: 'Success', message: 'likes deleted' }, status: 200
        else
            render json: { status: 'Failure', message: 'Failed to delete likes' }, status: 422
        end
    end

    def show
        @likes = PostLike.where(post_id: params[:id])
        render json: { status: 'Success', message: 'Successful', data: @likes }, status: 200
    end

    def likes_params
        params.require(:post_like).permit( :post_id)
    end
end
