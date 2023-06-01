class Follower < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :follower_user, class_name: 'User'

  after_save :add_following
  after_destroy :remove_following

  def add_following
    Following.create(user: follower_user, following_user: user)
  end

  def remove_following
    follow = Following.where(user: follower_user, following_user: user)
    follow.each { |foll| Following.destroy(foll.id) }
  end
end
