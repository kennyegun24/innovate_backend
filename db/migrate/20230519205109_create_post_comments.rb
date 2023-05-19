class CreatePostComments < ActiveRecord::Migration[7.0]
  def change
    create_table :post_comments do |t|

      t.string :commentor_name
      t.string :commentor_image
      t.string :text
      t.references :user, foreign_key: { to_table: :users }
      t.references :post, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
