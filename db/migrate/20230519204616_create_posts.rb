class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|

      t.string :creator_name
      t.string :creator_image
      t.string :text
      t.string :image
      t.string :likes_count
      t.string :comments_count
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
