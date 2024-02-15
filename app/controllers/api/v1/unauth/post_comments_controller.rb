class Api::V1::Unauth::PostCommentsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[index]
  def index
    page_number = params[:page] || 1
    per_page = 15
    @comment = Post.find(params[:id]).post_comments.paginate(page: page_number, per_page: per_page)
    render json: { status: 'Success', message: 'Successful', data: @comment }, status: 200
  end
end
