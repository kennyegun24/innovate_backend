class AddFollowingKeysToCompany < ActiveRecord::Migration[7.0]
  def change
    add_reference :followers, :company, foreign_key: true, null: true
    add_reference :followings, :company, foreign_key: true, null: true
    add_reference :followings, :following_company, null: true, foreign_key: { to_table: :companies }
    add_reference :followers, :follower_company, null: true, foreign_key: { to_table: :companies }

  end
end
