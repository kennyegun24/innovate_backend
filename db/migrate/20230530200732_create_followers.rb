class CreateFollowers < ActiveRecord::Migration[7.0]
  def change
    create_table :followers do |t|
      t.references :user, null: true, foreign_key: true
      t.references :follower_user, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
