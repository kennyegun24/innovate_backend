class CreateArticleComments < ActiveRecord::Migration[7.0]
  def change
    create_table :article_comments do |t|
      t.string :user_name
      t.string :user_image
      t.string :text
      t.references :articles, foreign_key: { to_table: :articles }
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
