class CompanyDetail < ApplicationRecord
  belongs_to :company

  validates :company_image, presence: true
  validates :company_name, presence: true
  validates :capacity, presence: true
  validates :about, presence: true
  validates :post_count, presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :followers_count, presence: true,numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :open_jobs, presence: true
  validates :header, presence: true, length: {maximum: 40}

end
