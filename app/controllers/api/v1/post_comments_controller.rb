class Api::V1::PostCommentsController < ApplicationController
    def create
        @comment = PostComment.new(comment_params)
        @comment.user = current_user

        if @comment.save
            render json: {status: 'Successful', message: 'Comment added'}, status: 201
        else
            render json: {status: 'Failure', message: 'Something went wrong'}, status: 422
        end
    end

    def destroy
        @comment = PostComment.find(params[:id])

        if @comment.destroy
            render json: { status: 'Success', message: 'Comment deleted' }, status: 200
        else
            render json: { status: 'Failure', message: 'Failed to delete comment' }, status: 422
        end
    end

    def comment_params
        params.require(:post_comment).permit( :post_id, :text)
    end
end
