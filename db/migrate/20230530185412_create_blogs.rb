class CreateBlogs < ActiveRecord::Migration[7.0]
  def change
    create_table :blogs do |t|
      t.string :author_name
      t.string :author_image
      t.integer :likes_counter
      t.integer :comments_counter
      t.integer :articles_counter
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
