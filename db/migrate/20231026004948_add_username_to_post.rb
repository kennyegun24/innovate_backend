class AddUsernameToPost < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :user_name, :string
    add_column :articles, :author_id, :bigint, null: false
  end
end
