class ChangeWorkToUid < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :work, :uid
  end
end
