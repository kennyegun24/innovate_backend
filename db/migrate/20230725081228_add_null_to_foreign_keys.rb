class AddNullToForeignKeys < ActiveRecord::Migration[7.0]
  def change
    change_column_null :applied_jobs, :job_id, false
    change_column_null :applied_jobs, :user_id, false
    change_column_null :company_details, :company_id, false
    change_column_null :jobs, :company_id, false
  end
end
