class Job < ApplicationRecord
  belongs_to :company
  has_many :applied_jobs,dependent: :destroy

  before_validation :update_company_name
  after_save :update_company_jobs

  validates :company_image, presence: true
  validates :company_name, presence: true
  validates :description, presence: true
  validates :title, presence: true
  validates :expiry_date, presence: true
  validates :location, presence: true
  validates :experience_level, presence: true
  validates :no_of_applicants, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

  def update_company_name
    if company.present? && company.company_detail.present?
      self.company_name = company.company_detail.company_name
      self.company_image = company.company_detail.company_image
    end
  end

  def update_company_jobs
    company.company_detail.update(open_jobs: company.jobs.count)
  end
end
