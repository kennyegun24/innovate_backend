class CreateCompanyDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :company_details do |t|

      t.string :company_name
      t.string :capacity
      t.string :creation_date
      t.string :about
      t.integer :post_count
      t.integer :followers_count
      t.integer :open_jobs
      t.string :company_image
      t.references :company, foreign_key: {to_table: :companies}
      t.string :header
      t.timestamps
    end
  end
end
