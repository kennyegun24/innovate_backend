class Api::V1::Auth::BlogsController < ApplicationController
  # Create method to allow user create a blog account
  # Create method to delete articles

  def create
    # @article = current_user.blog.build(article_params)
    @blog = current_user.blog # Assuming you have a current_user method that returns the user
    @article = @blog.articles.build(article_params)

      if @article.save
        # Handle successful article creation
        render json: {message: 'Success'}, status: 200
      else
        # Handle validation errors
        render json: {
          status: 'Failure',
          message: @article.errors.full_messages
        }, status: 200
      end
  end

  def destroy
    @article = current_user.blog.articles.find_by(id: params[:id])

    if @article
      @article.destroy
      render json: {
        message: 'Article deleted now'
      }
    else
      render json: {
        message: 'Article not found'
      }
    end
  end

  def index

  end

  def article_params
    params.require(:article).permit(:title, :text, :author_name, :image)
  end
end

# {
#   "status": "success",
#   "message": "User created",
#   "data": {
#     "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyNTQsImV4cCI6MTY5NDEwMTM4OH0.xL5JlRq04adiu4p769fBMgkimHhnGDjZCXV_R_v4plY",
#     "use_id": 254,
#     "type": "individual"
#   }
# }
