class AddDefaultValues < ActiveRecord::Migration[7.0]
  def change
    change_column_null :posts, :author_id, false
    change_column_null :posts, :author_id, false
    change_column_null :post_likes, :post_id, false
    change_column_null :post_likes, :user_id, false
    change_column_null :post_comments, :post_id, false
    change_column_null :post_comments, :user_id, false
    change_column_null :work_experiences, :user_id, false
    change_column_null :users, :name, false
    change_column_null :users, :user_name, false
    change_column_null :users, :email, false
    change_column_default :posts, :likes_count, 0
    change_column_default :posts, :comments_count, 0
    change_column_default :users, :blogs_count, 0
    change_column_default :users, :posts_count, 0
  end
end
