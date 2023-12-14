class Api::V1::SearchController < ApplicationController
  skip_before_action :authenticate_request, only: %i[users_query_search posts_query_search]
  def posts_query_search
    query = params[:query]
    per_page = 10
    page_number = params[:page] || 1

    if query.length >= 4
      @posts = Post.where("LOWER(text) LIKE :query OR LOWER(creator_name) LIKE :query", query: "%#{query.downcase}%").paginate(page: page_number, per_page: per_page)
      
      render json: { message: 'Fetched posts search', data: @posts }, status: 200
    else
      posts = []
      render json: {data: posts}, status: 200
    end
  end

  def users_query_search
    query = params[:query]
    per_page = 10
    page_number = params[:page] || 1

    if query.length >= 4
      @users = User.where("LOWER(name) LIKE :query OR LOWER(user_name) LIKE :query", query: "%#{query.downcase}%").select(:id, :name, :image, :user_name, :header).paginate(page: page_number, per_page: per_page)

      render json: { message: 'Fetched user data', data: @users }, status: 200
    else
      users = []
      render json: {data: users}, status: 200
    end
  end
end