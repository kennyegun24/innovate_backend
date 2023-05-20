class CreateFollowers < ActiveRecord::Migration[6.0]
  def change
    create_table :followers do |t|
      t.string :name
      t.string :photo
      t.references :follower, foreign_key: { to_table: :users }
      t.references :user, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
