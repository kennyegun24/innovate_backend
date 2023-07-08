class Api::V1::Auth::PostCommentsController < ApplicationController
    def create
        @comment = PostComment.new(comment_params)
        @comment.user = current_user

        if @comment.save
            render json: {status: 'Successful', message: 'Comment added'}, status: 201
        else
            render json: {status: 'Failure', message: @comment.errors.full_messages}, status: 422
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @comment = @post.post_comments.find_by(id: params[:comment_id], user_id: current_user.id)

        if @comment
            if @comment.destroy
                render json: { status: 'Success', message: 'Comment deleted' }, status: 200
            else
                render json: { status: 'Failure', message: 'Failed to delete comment' }, status: 422
            end
        else
            render json: { status: 'Failure', message: 'Comment not found' }, status: 404
        end
    end

    def index
        @comment = PostComment.where(post_id: params[:id])
        render json: { status: 'Success', message: 'Successful', data: @comment }, status: 200
    end

    def comment_params
        params.require(:post_comment).permit( :post_id, :text)
    end
end
