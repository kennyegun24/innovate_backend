class User < ApplicationRecord
    has_secure_password

    has_many :posts, foreign_key: 'author_id', class_name: 'Post'
    has_many :post_comments
    has_many :post_likes
    has_many :work_experiences

    has_many :blogs
    has_many :articles
    has_many :article_comments
    has_many :article_likes

    # FOllowers relationship
    has_many :followers, foreign_key: :user_id, class_name: 'Follower'
    has_many :followed_users, through: :followers, source: :follower_user

    has_many :followings, foreign_key: :user_id, class_name: 'Following'
    has_many :following_users, through: :followings, source: :following_user

    validates :name, presence: true
    validates :user_name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :profession, length: {maximum: 20}
    validates :header, length: {maximum: 100}
    validates :about, length: {maximum: 1000}
    validates :bio, length: {maximum: 500}

    after_save :update_posts_with_profile_image

    private
  
    def update_posts_with_profile_image
      if saved_change_to_image?
        self.posts.update_all(creator_image: image)
      end
    end
end
