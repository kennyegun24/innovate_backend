class AddDefaultValueToCompany < ActiveRecord::Migration[7.0]
  def change
    change_column_default :company_details, :post_count, 0
    change_column_default :company_details, :followers_count, 0
    change_column_default :company_details, :open_jobs, 0
    change_column_default :jobs, :no_of_applicants, 0
  end
end
