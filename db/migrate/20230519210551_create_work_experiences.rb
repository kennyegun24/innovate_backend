class CreateWorkExperiences < ActiveRecord::Migration[7.0]
  def change
    create_table :work_experiences do |t|

      t.string :company_name
      t.string :title
      t.string :description
      t.string :start_date
      t.string :end_date

      t.references :user, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
