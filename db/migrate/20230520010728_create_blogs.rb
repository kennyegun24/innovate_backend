class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :author_name
      t.string :author_image
      t.text :desc
      t.string :image
      t.references :author, foreign_key: true
      t.integer :like_counter, default: 0
      t.integer :comments_counter, default: 0

      t.timestamps
    end
  end
end

