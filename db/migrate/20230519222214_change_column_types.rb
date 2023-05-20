class ChangeColumnTypes < ActiveRecord::Migration[7.0]
  def change
    change_column_default :posts, :likes_count, nil
    change_column_default :posts, :comments_count, nil
    change_column_default :users, :blogs_count, nil
    change_column_default :users, :posts_count, nil
    change_column :users, :blogs_count, 'integer USING CAST(blogs_count AS integer)'
    change_column :users, :posts_count, 'integer USING CAST(posts_count AS integer)'
    change_column :posts, :comments_count, 'integer USING CAST(comments_count AS integer)'
    change_column :posts, :likes_count, 'integer USING CAST(likes_count AS integer)'
    change_column_default :posts, :likes_count, 0
    change_column_default :posts, :comments_count, 0
    change_column_default :users, :blogs_count, 0
    change_column_default :users, :posts_count, 0
  end
end
