class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :text
      t.string :author_name
      t.string :author_image
      t.integer :likes_counter
      t.integer :comments_counter
      t.string :image
      t.references :blogs, foreign_key: { to_table: :posts }

      t.timestamps
    end
  end
end
