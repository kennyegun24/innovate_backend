class RemovePostRefFromArticles < ActiveRecord::Migration[7.0]
  def change
    remove_reference :articles, :blogs, null: false, foreign_key: { to_table: :posts }
  end
end
