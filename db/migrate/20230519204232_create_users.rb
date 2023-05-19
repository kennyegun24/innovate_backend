class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|

      t.string :name
      t.string :user_name
      t.string :email
      t.string :password_digest
      t.string :image
      t.string :header
      t.string :about
      t.string :bio
      t.string :profession
      t.string :location
      t.string :blogs_count
      t.string :posts_count
      t.string :website1
      t.string :website2
      t.string :website3

      t.timestamps
    end
  end
end
