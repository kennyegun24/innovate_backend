class Api::V1::BlogsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index show three_other_posts search_articles]

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

  
  def three_other_posts
    @articles = Article.where(blogs_id: params[:id])
    if @articles
      @blogs = @articles.limit(3).order(created_at: :desc)

      if @blogs
        render json: {message: 'success', data: @blogs}, status: 200
      else
        render json:{message: 'Could not find articles', data: []}, status: 200
      end
    else
      render json:{message: 'User has no blog', data: []}, status: 200
    end
  end

  def search_articles
    query = params[:query]
    per_page = 5
    page_number = params[:page] || 1

    if query.length >= 4
      @articles = Article.where("LOWER(text) LIKE :query OR LOWER(title) LIKE :query", query: "%#{query.downcase}%").paginate(page: page_number, per_page: per_page)
      
      render json: { message: 'Fetched articles', data: @articles }, status: 200
    else
      articles = []
      render json: {essage: 'Query less than 4',data: articles}, status: 200
    end
  end
end
