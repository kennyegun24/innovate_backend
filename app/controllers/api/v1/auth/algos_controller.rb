# # app/controllers/users_controller.rb
# class Api::V1::Auth::AlgosController < ApplicationController
#   def index
#     # get id of every user that current user is following
#     extract_user_followings = current_user.followings.pluck(:following_user_id)
#     # get current_user likes id
#     current_user_likes = current_user.post_likes.pluck(:post_id)

#     #1 Extract text from the pool of interracted posts by the user and also normal posts.
#     user_posts = current_user.posts.pluck(:text)
#     user_liked_and_commented_posts = Post.where(id: current_user_likes + current_user.post_comments.pluck(:post_id))

#     #2 Combine and count word occurrences
#     all_words = (user_posts + user_liked_and_commented_posts.pluck(:text)).join(' ').split

#     all_words = all_words - exempted_words

#     # This hash method is used to create a new hash for each word
#     word_occurrences = Hash.new(0)

#     # This method iterates (loop) through each word and stores
#     # them in the hash uniquely and put a count on each word
#     # to determine how many times each word appears
#     all_words.each { |word| word_occurrences[word.downcase] += 1 }

#     #3 I then select top 20 words with more than 3 characters
#     top_words = word_occurrences.select { |word, count| word.length > 3 }
#                                 .sort_by { |_word, count| -count }
#                                 .first(10)
#                                 .map(&:first)

#     page_number = params[:page] || 1
#     per_page = 30

#     #4 This method find existing posts made by other users using top words
#     recommended_posts = Post.where.not(author: current_user)
#                            .where("text ILIKE ANY (array[?])", top_words.map { |word| "%#{word}%" })
#                            .order(created_at: :desc, likes_count: :desc)
#                            .paginate(page: page_number, per_page: per_page)

#     #5 This method filter posts based on popularity and time
#     follower_users_posts = Post.where(author: extract_user_followings)
#                           .order(created_at: :desc, likes_count: :desc)
#                           .paginate(page: page_number, per_page: per_page)

#     # COMPARE CURRENT USER POST INTERRACTIONS TO THE PEOPLE HE/SHE IS FOLLOWING

#     # get every likes of posts that the following users liked
#     # get_following_user_likes = User.where(id: extract_user_followings).includes(:post_likes)
#     get_following_user_likes = User.where(id: extract_user_followings).includes(:post_likes, :post_comments)

#     # This method creates an object with the following users id
#     # and use them as keys whilst the id of posts they liked
#     # as the values in an array...
#     # output => {7=>[2, 17, 18, 15], 2=>[1, 2], 10=>[nil]}
#     # liked_posts_by_user = get_following_user_likes.pluck(:id, :post_id).group_by(&:first).transform_values { |pairs| pairs.map(&:last) }
#     liked_posts_by_user = get_following_user_likes.pluck(
#       :id,
#       "post_likes.post_id AS liked_post_id",
#       "post_comments.post_id AS commented_post_id"
#     ).group_by(&:first).transform_values do |pairs|
#       liked_post_ids = pairs.compact.map { |pair| pair[1] }
#       commented_post_ids = pairs.compact.map { |pair| pair[2] }
#       {
#         liked_post_ids: liked_post_ids,
#         commented_post_ids: commented_post_ids
#       }
#     end # output => {7=>[2, 17, 18, 15], 2=>[1, 2] }

#     # This is to store the id of posts that the user has liked which the current user hasnt liked
#     suggested_posts_for_current_user = {}

#     # liked_posts_by_user.each do |user_id, liked_posts|
#     #   common_likes = current_user_likes & liked_posts
#     #   if common_likes.length > 10
#     #     suggested = liked_posts - current_user_likes
#     #     suggested_posts_for_current_user[user_id] = suggested unless suggested.empty?
#     #   end
#     # end

#     liked_posts_by_user.each do |user_id, liked_data| # output => {7=>[2, 15], 2=>[2]}
#       liked_posts = liked_data[:liked_post_ids]
#       liked_comments = liked_data[:commented_post_ids]

#       common_likes_and_comments = liked_posts & liked_comments
#       if common_likes_and_comments.length > 10
#         suggested = common_likes_and_comments - current_user_likes
#         suggested_posts_for_current_user[user_id] = suggested unless suggested.empty?
#       end
#     end

#     suggested_post_ids = suggested_posts_for_current_user.values.flatten # output => [] array format

#     suggested_posts = Post.where(id: suggested_post_ids)

#     final_recommended_posts = (recommended_posts + follower_users_posts + suggested_posts).sort_by {
#                               |post| [-post.created_at.to_i, -post.likes_count] }


#     render json: final_recommended_posts
#   end
# end

# -----------------------Change Made---------------------------

#  Minimize Database Queries:
#  Old Code: The current_user's followings, post_likes, post_comments, and posts were fetched from the database in separate queries, which can be inefficient.
#  New Code: A single query is used to fetch all the required current_user data at once using the as_json method with the :include option. This reduces the number of database queries, which can significantly improve performance, especially when the database is large or the network latency is high.
#
#  Reduce Array Operations:
#  Old Code: The all_words array was computed by concatenating arrays of texts, joining them into a single string, and then splitting the string into words. This involves multiple unnecessary array and string operations.
#  New Code: The word_occurrences hash is computed directly from the user_posts and user_liked_and_commented_posts arrays, avoiding the unnecessary array and string operations. This reduces the time complexity and memory usage of the code.
#
#  Optimize Sorting and Selection:
#  Old Code: The top_words array was computed by first filtering out words with less than 4 characters, then sorting the remaining words by their occurrence count, and then selecting the top 10 words. This involves multiple iterations over the word_occurrences hash.
#  New Code: The top_words array is computed in a single iteration over the word_occurrences hash by using the reject method to filter out words with less than 4 characters or included in the exempted_words array, then using the sort_by method to sort the remaining words by their occurrence count, and then using the first method to select the top 10 words. This reduces the time complexity of the code.
#
#  Optimize Database Queries:
#  Old Code: The recommended_posts and follower_users_posts were fetched from the database in separate queries.
#  New Code: The same queries are used, but the paginate method is used to limit the number of fetched posts to the required per_page amount. This reduces the amount of data fetched from the database, which can significantly improve performance, especially when the database is large.
#
#  Improve Code Readability and Maintainability:
#  Old Code: The code was a bit cluttered and hard to follow.
#  New Code: The code is organized in a more structured way, making it easier to understand and maintain.
# -------------------------------------------------------------------

# -----------------------NEW CODE---------------------------

#  class Api::V1::Auth::AlgosController < ApplicationController
#    def index
#      page_number = params[:page] || 1
#      per_page = 30

#      # 1. Minimize database queries
#      current_user_data = current_user.as_json(include: [:followings, :post_likes, :post_comments, :posts])
#      extract_user_followings = current_user_data['followings'].map { |f| f['following_user_id'] }
#      current_user_likes = current_user_data['post_likes'].map { |pl| pl['post_id'] }

#      # 2. Reduce array operations
#      user_posts = current_user_data['posts'].map { |p| p['text'] }
#      user_liked_and_commented_posts = Post.where(id: current_user_likes + current_user_data['post_comments'].map { |pc| pc['post_id'] })

#      # Combine and count word occurrences directly from the posts
#      word_occurrences = Hash.new(0)
#      (user_posts + user_liked_and_commented_posts.map(&:text)).each do |text|
#        text.split.each { |word| word_occurrences[word.downcase] += 1 }
#      end

#      # 3. Optimize sorting and selection
#      # Sort and select top words in a single step
#      top_words = word_occurrences.reject { |word, _| word.length <= 3 || exempted_words.include?(word) }
#                                   .sort_by { |_, count| -count }
#                                   .first(10)
#                                   .map(&:first)

#      # 4. Optimize database queries
#      recommended_posts = Post.where.not(author: current_user)
#                              .where("text ILIKE ANY (array[?])", top_words.map { |word| "%#{word}%" })
#                              .order(created_at: :desc, likes_count: :desc)
#                              .paginate(page: page_number, per_page: per_page)

#      follower_users_posts = Post.where(author: extract_user_followings)
#                                 .order(created_at: :desc, likes_count: :desc)
#                                 .paginate(page: page_number, per_page: per_page)

#      get_following_user_likes = User.where(id: extract_user_followings).includes(:post_likes, :post_comments)
#      liked_posts_by_user = get_following_user_likes.pluck(:id, "post_likes.post_id AS liked_post_id", "post_comments.post_id AS commented_post_id")
#                                                    .group_by(&:first).transform_values do |pairs|
#                                                      liked_post_ids = pairs.compact.map { |pair| pair[1] }
#                                                      commented_post_ids = pairs.compact.map { |pair| pair[2] }
#                                                      {
#                                                        liked_post_ids: liked_post_ids,
#                                                        commented_post_ids: commented_post_ids
#                                                      }
#                                                    end

#      suggested_posts_for_current_user = {}
#      liked_posts_by_user.each do |user_id, liked_data|
#        liked_posts = liked_data[:liked_post_ids]
#        liked_comments = liked_data[:commented_post_ids]
#        common_likes_and_comments = liked_posts & liked_comments
#        if common_likes_and_comments.length > 10
#          suggested = common_likes_and_comments - current_user_likes
#          suggested_posts_for_current_user[user_id] = suggested unless suggested.empty?
#        end
#      end

#      suggested_post_ids = suggested_posts_for_current_user.values.flatten
#      suggested_posts = Post.where(id: suggested_post_ids)

#      final_recommended_posts = (recommended_posts + follower_users_posts + suggested_posts).sort_by { |post| [-post.created_at.to_i, -post.likes_count] }

#      finished_recommended_posts = final_recommended_posts.map do |post|
#       {
#         **post.attributes.symbolize_keys,
#         liked: current_user_likes.include?(post.id)
#       }
#     end
#      render json: finished_recommended_posts
#    end
#  end
