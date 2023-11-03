class Api::V1::BlogsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]

  def index
    # page_number = params[:page] || 2
    # per_page = 10
      @top_articles = Article.all.order(likes_counter: :desc).limit(5)
      @new_articles = Article.all.order(created_at: :desc).limit(5)
      @articles = [*@top_articles, *@new_articles]
      render json: { message: 'All blogs', data:@articles }
  end

  def show
    # code for showing a specific blog article
    @article = Article.find_by(id: params[:id])
    if @article
      render json:{message: 'success', data: @article}, status: 200
    else
      render json:{message: 'Could not find article', data: {}}, status: 200
    end
  end
end
