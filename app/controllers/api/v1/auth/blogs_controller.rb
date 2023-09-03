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
    @articles = current_user.blog.articles.order(likes_counter: :desc).map do |article|
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

  # show general blogs to current user
  def show_blogs
    page_number = params[:page] || 2
    per_page = 20

    # 1. Minimize database queries
    current_user_data = current_user.as_json(include: { blog: { include: :articles }, posts: {} })
    extract_user_posts = current_user_data['posts'].map { |f| f['text'] }
    current_user_blogs = current_user_data['blog']["articles"].map { |pl| pl['title'] }

    word_occurrences = Hash.new(0)
    joined_posts_article_words = extract_user_posts + current_user_blogs

    joined_posts_article_words.each do |word|
      word.split.each  { |word| word_occurrences[word.downcase] += 1 }
    end

    top_words = word_occurrences.reject { |word, _| word.length <= 3 }
                                .sort_by { |_, count| -count }
                                .first(10)
                                .map(&:first)

    recommended_articles = Article.where("title ILIKE ANY (array[?]) OR text ILIKE ANY (array[?])",
                                          top_words.map { |word| "%#{word}%" },
                                          top_words.map { |word| "%#{word}%" },
                                        )
                                    .order(created_at: :desc, likes_counter: :desc)
                                    .paginate(page: page_number, per_page: per_page)
    render json: recommended_articles
  end

  def article_params
    params.require(:article).permit(:title, :text, :author_name, :image)
  end
end
