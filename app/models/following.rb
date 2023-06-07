class Following < ApplicationRecord
  belongs_to :user
  belongs_to :following_user, class_name: 'User'

  after_create :update_following
  after_destroy :reduce_counter

  private

  def update_following
    user.increment!(:following_count)
  end

  def reduce_counter
    user.decrement!(:following_count)
  end
end
