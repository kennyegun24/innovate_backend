class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|

      t.string :company_name
      t.string :company_image
      t.string :description
      t.string :title
      t.string :expiry_date
      t.string :location
      t.string :experience_level
      t.integer :no_of_applicants
      t.references :company, foreign_key: {to_table: :companies}

      t.timestamps
    end
  end
end
