class ChangeDefaultValue < ActiveRecord::Migration[7.0]
  def change
    change_column_default :blogs, :articles_counter, 0
    change_column_default :blogs, :likes_counter, 0
    change_column_default :blogs, :comments_counter, 0
    change_column_default :articles, :comments_counter, 0
    change_column_default :articles, :likes_counter, 0
  end
end
