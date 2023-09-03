class Api::V1::Auth::ArticleCommentsController < ApplicationController
  def create
    @article = Article.find_by(id: params[:id])

    if @article
      @article_comment = @article.article_comments.build(author_id: current_user.id, text: params[:text])
      if @article_comment.save
        render json: {status: 'Successful', message: 'Comment added'}, status: 201
      else
        render json: {status: 'Failure', message: @article_comment.errors.full_messages}, status: 422
      end
    else
      render json: {status: 'Failure', message: @article.errors.full_messages}, status: :not_found
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @comment = @article.article_comments.find_by(id: params[:comment_id], author_id: current_user.id)

    if @comment
      if @comment.destroy
        render json: { status: 'Success', message: 'Comment deleted' }, status: 200
      else
        rennder json: { status: 'Failure', message: 'Failed to delete comment' }, status: 422
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
        params.require(:article_comments).permit(:text)
    end
end
