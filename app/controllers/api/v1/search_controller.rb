class Api::V1::SearchController < ApplicationController
    skip_before_action :authenticate_request, only: %i[query_search]
    def query_search
        query = params[:query]
        per_page = 10
        page_number = params[:page] || 1
    
        if query.length >= 4
            @posts = Post.where("LOWER(text) LIKE :query OR LOWER(creator_name) LIKE :query", query: "%#{query.downcase}%").paginate(page: page_number, per_page: per_page)
            @users = User.where("LOWER(name) LIKE :query OR LOWER(user_name) LIKE :query", query: "%#{query.downcase}%").select(:id, :name, :image, :profession).paginate(page: page_number, per_page: per_page)

            @combined_array = [
                *@posts.map do |post|
                    {
                        'post_id' => post['id'],
                        "creator_name" => post["creator_name"],
                        "creator_image" => post["creator_image"],
                        "post_text" => post["text"],
                        "post_image" => post["image"],
                        "likes_count" => post["likes_count"],
                        "comments_count" => post["comments_count"],
                        "author_id" => post["author_id"],
                        "created_at" => post["created_at"],
                        "updated_at" => post["updated_at"],
                    }
                end,
                *@users.map do  |user|
                    {
                        "user_id" => user["id"],
                        "user_name" => user["name"],
                        "profession" => user["profession"],
                        'user_image' => user['image']
                        'user_header' => user['header']
                    }
                end
            ]
            
            render json: { message: 'Fetched user data', data: @combined_array }, status: 200
        else
            users = []
            posts = []
            combined_array = [
                *users,
                *posts
            ]
            render json: {data: combined_array}, status: 200
        end
    end
end