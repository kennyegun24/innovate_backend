class Api::V1::Auth::PostsController < ApplicationController

  def create
    @post = current_user.posts.create(post_params)

    if @post.save
      render json: {status: 'Successful', message: 'Post created'}, status: 201
    else
      render json: {status: 'Failed', message: @post.errors.full_messages}, status: 422
    end
  end

  # Lists of posts to be displayed when there iis an authenticated user
  def index
    page_number = params[:page] || 1
    per_page = 30

    # 1. Minimize database queries
    current_user_data = current_user.as_json(include: [:followings, :post_likes, :post_comments, :posts])
    extract_user_followings = current_user_data['followings'].map { |f| f['following_user_id'] }
    current_user_likes = current_user_data['post_likes'].map { |pl| pl['post_id'] }

    # 2. Reduce array operations
    user_posts = current_user_data['posts'].map { |p| p['text'] }
    user_liked_and_commented_posts = Post.where(id: current_user_likes + current_user_data['post_comments'].map { |pc| pc['post_id'] })

    # Combine and count word occurrences directly from the posts
    word_occurrences = Hash.new(0)
    (user_posts + user_liked_and_commented_posts.map(&:text)).each do |text|
      text.split.each { |word| word_occurrences[word.downcase] += 1 }
    end

    # 3. Optimize sorting and selection
    # Sort and select top words in a single step
    top_words = word_occurrences.reject { |word, _| word.length <= 3 || exempted_words.include?(word) }
                                .sort_by { |_, count| -count }
                                .first(10)
                                .map(&:first)

    # 4. Optimize database queries
    recommended_posts = Post.where.not(author: current_user)
                            .where("text ILIKE ANY (array[?])", top_words.map { |word| "%#{word}%" })
                            .order(created_at: :desc, likes_count: :desc)
                            .paginate(page: page_number, per_page: per_page)

    follower_users_posts = Post.where(author: extract_user_followings)
                              .order(created_at: :desc, likes_count: :desc)
                              .paginate(page: page_number, per_page: per_page)

    get_following_user_likes = User.where(id: extract_user_followings).includes(:post_likes, :post_comments)
    liked_posts_by_user = get_following_user_likes.pluck(:id, "post_likes.post_id AS liked_post_id", "post_comments.post_id AS commented_post_id")
                                                  .group_by(&:first).transform_values do |pairs|
                                                    liked_post_ids = pairs.compact.map { |pair| pair[1] }
                                                    commented_post_ids = pairs.compact.map { |pair| pair[2] }
                                                    {
                                                      liked_post_ids: liked_post_ids,
                                                      commented_post_ids: commented_post_ids
                                                    }
                                                  end

    suggested_posts_for_current_user = {}
    liked_posts_by_user.each do |user_id, liked_data|
      liked_posts = liked_data[:liked_post_ids]
      liked_comments = liked_data[:commented_post_ids]
      common_likes_and_comments = liked_posts & liked_comments
      if common_likes_and_comments.length > 10
        suggested = common_likes_and_comments - current_user_likes
        suggested_posts_for_current_user[user_id] = suggested unless suggested.empty?
      end
    end

    suggested_post_ids = suggested_posts_for_current_user.values.flatten
    suggested_posts = Post.where(id: suggested_post_ids)

    final_recommended_posts = (recommended_posts + follower_users_posts + suggested_posts).sort_by { |post| [-post.created_at.to_i, -post.likes_count] }

    finished_recommended_posts = final_recommended_posts.map do |post|
    {
      **post.attributes.symbolize_keys,
      liked: current_user_likes.include?(post.id)
    }
  end
  puts(finished_recommended_posts.count)
    render json: finished_recommended_posts
  end

  # Post details to be displayed when there  an authenticated user
  def show
    @post = Post.find(params[:id])
    @isLiked = @post.post_likes.pluck(:user_id).include?(current_user.id)

    @isFollowed = @post.author.followers.pluck(:follower_user_id).include?(current_user.id)
    one_post = {
      **@post.attributes.symbolize_keys,
      liked: @isLiked,
      isFollowed: @isFollowed
    }
    render json: {status: 'Successful', message: 'Post', data: one_post}, status: 200
  end

  # All posts for the authenticated user
  def current_user_posts
    @posts = current_user.posts.includes(:post_likes).order(created_at: :desc)
    render json: {message: 'Curren user posts', status: 'Successful', data: @posts}, status: 200
  end

  # All posts for other user
  def other_users_posts
    @user = User.find(params[:id])
    @posts = @user.posts.all.order(created_at: :DESC)
    render json: {message: 'User posts', status: 'Successful', data: @posts, id: @user.id}, status: 200
  end

  def destroy
    @post = current_user.posts.destroy(params[:id])
    render json: {message: 'Post Deleted', status: 'Successful'}, status: 200
  end

  def post_params
    params.require(:post).permit(:text, :image)
  end
end
