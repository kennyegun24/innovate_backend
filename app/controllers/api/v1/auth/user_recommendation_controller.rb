class Api::V1::Auth::UserRecommendationController < ApplicationController
  def index
    page_number = params[:page] || 1
    per_page = 30
    all_user_details_words = User.where(id: current_user.id).pluck(:bio, :profession, :header, :about).first.join(' ').split


    allowed_user_details_words = all_user_details_words.map(&:downcase) - exempted_words.map(&:downcase)
    word_occurrences = Hash.new(0)

    allowed_user_details_words.each { |word| word_occurrences[word.downcase] += 1 }

    #3 I then select top 20 words with more than 3 characters
    top_profile_words = word_occurrences.select { |word, count| word.length >= 5 }
                              .sort_by { |_word, count| -count }
                              .first(20)
                              .map(&:first)

    find_users = User.where.not(id: current_user.id)
      .where(
        "bio ILIKE ANY (array[?]) OR about ILIKE ANY (array[?]) OR profession ILIKE ANY (array[?])",
        top_profile_words.map { |word| "%#{word}%" },
        top_profile_words.map { |word| "%#{word}%" },
        top_profile_words.map { |word| "%#{word}%" }
      )
    .paginate(page: page_number, per_page: per_page).select(:name, :header, :image, :id)
    render json: find_users
  end
end
