class PostLike < ApplicationRecord
    belongs_to :user
    belongs_to :post

    after_create :update_likes_count
    before_save :update_image_name
    after_destroy :reduce_likes_count

    def update_likes_count
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
