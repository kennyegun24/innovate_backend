class PostLike < ApplicationRecord
    belongs_to :user
    belongs_to :post

    after_save :update_posts_count
    before_save :update_image_name
    after_destroy :reduce_likes_count

    def update_posts_count
        post.update(likes_count: post.post_likes.count)
    end

    def update_image_name
        self.user_image = user.image
        self.user_name = user.name
    end

    def reduce_likes_count
        post.update(likes_count: post.post_likes.count)
    end
end
