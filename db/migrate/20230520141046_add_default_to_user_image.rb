class AddDefaultToUserImage < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :image, 'https://res.cloudinary.com/drfqge33t/image/upload/v1684591863/noImage_ynt833.png'
  end
end
