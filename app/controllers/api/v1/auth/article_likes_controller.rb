class Api::V1::Auth::ArticleLikesController < ApplicationController
  def like_unlike
    @blog = Article.find_by(id: params[:id])
    if @blog
      @likes = @blog.article_likes.find_by(user_id: current_user.id)

      if @likes
        if @likes.destroy
          render json: {message: 'unliked', status: 'Success'}
        else
          render json: { status: 'Failure', message: 'Failed to unlike blog' }, status: 422
        end
      else
        @likes = @blog.article_likes.new(user: current_user)
        @likes.user = current_user

        if @likes.save
          render json: {status: 'Successful', message: 'likes added'}, status: 201
        else
          render json: {status: 'Failure', message: @likes.errors.full_messages}, status: 422
        end
      end
    end
  end
end
