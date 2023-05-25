class PostComment < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

    validates :text, presence: true, length: { minimum: 3, maximum: 150}

    after_save :update_posts_count
    before_save :update_image_name
    after_destroy :reduce_comments_count

    def update_posts_count
        post.update(comments_count: post.post_comments.count)
    end

    def update_image_name
        self.commentor_image = user.image
        self.commentor_name = user.name
    end

    def reduce_comments_count
        post.update(comments_count: post.post_comments.count)
    end
end
