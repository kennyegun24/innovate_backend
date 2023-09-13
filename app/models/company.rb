class Company < ApplicationRecord
  has_secure_password
  has_one :company_detail
  has_many :jobs
  has_many :followers, foreign_key: :company_id, class_name: 'Follower'
  has_many :user_followers, through: :followers, source: :follower_user

  has_many :followings, foreign_key: :company_id, class_name: 'Following'
  has_many :user_following, through: :followings, source: :following_user
  validates :email, presence: true, uniqueness: true
end
