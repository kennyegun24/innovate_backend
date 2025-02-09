class Post < ApplicationRecord
    belongs_to :author, class_name: 'User', foreign_key: 'author_id'
    has_many :post_comments, dependent: :destroy
    has_many :post_likes, dependent: :destroy
    validates :text, presence: true, length: {minimum: 3, maximum: 1000}

    after_create :UpdatePostCount
    before_save :set_creator_image
    after_destroy :ReducePostCount

    def UpdatePostCount
        author.update(posts_count: author.posts.count)
    end

    def set_creator_image
        self.creator_image = author.image
        self.creator_name = author.name
        self.user_name = author.user_name
    end

    def ReducePostCount
        author.update(posts_count: author.posts.count)
    end
end
