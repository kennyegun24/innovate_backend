class CreateAppliedJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :applied_jobs do |t|

      t.references :job, foreign_key: {to_table: :jobs}
      t.references :user, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
