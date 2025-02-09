class CreateFollowings < ActiveRecord::Migration[7.0]
  def change
    create_table :followings do |t|
      t.references :user, null: true, foreign_key: true
      t.references :following_user, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
