class Api::V1::BlogsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]

  def index
    page_number = params[:page] || 2
    per_page = 10
      @articles = Article.all.order(likes_counter: :desc).paginate(page: page_number, per_page: per_page)
      render json: { message: 'User does not exist', data:@articles }
  end

  def show
    # code for showing a specific blog article
    @article = Article.find_by(id: params[:id])
    if @article
      render json:{message: 'success', data: @article}, status: 200
    else
      render json:{message: 'Could not find article'}, status: 404
    end
  end
end
