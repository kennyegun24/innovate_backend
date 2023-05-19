class CreatePostLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :post_likes do |t|

      t.string :user_image
      t.string :user_name
      t.references :user, foreign_key: { to_table: :users }
      t.references :post, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
