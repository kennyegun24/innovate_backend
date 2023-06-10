class AddExtraColumnsToUserTable < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :phoneNumber, :string
    add_column :users, :school, :string
    add_column :users, :company, :string
    add_column :users, :work, :string
    add_column :users, :start_date, :string
  end
end
