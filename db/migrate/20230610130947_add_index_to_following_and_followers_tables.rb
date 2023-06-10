class AddIndexToFollowingAndFollowersTables < ActiveRecord::Migration[7.0]
  def change
    add_index :followers, [:follower_user_id, :user_id], unique: true
    add_index :followings, [:following_user_id, :user_id], unique: true
  end
end
