class ChangeCompanyPasswood < ActiveRecord::Migration[7.0]
  def change
    remove_column :companies, :password, :string
    add_column :companies,  :password_digest, :string
  end
end
