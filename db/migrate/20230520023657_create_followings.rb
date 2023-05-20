class CreateFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :followings do |t|
      t.references :followed, foreign_key: { to_table: :users }
      t.references :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
