class Api::V1::Auth::BlogsController < ApplicationController
  # Create method to allow user create a blog account
  # Create method to delete articles
  # show all current user articles

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

  # list all current user articles
  def index
    @articles = current_user.blog.articles.map do |article|
    # Truncate the title to a maximum of 20 characters
      truncated_title = article.title.truncate(20, omission: '...')

      # Create a new hash with the truncated title
      {
        id: article.id,
        title: truncated_title,
        blogs_id: article.blogs_id,
        image: article.image,
        created_at: article.created_at,
        likes_counter: article.likes_counter,
        comments_counter: article.comments_counter,
      }
    end
    render json: { data: @articles }
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
