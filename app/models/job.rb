class Job < ApplicationRecord
  belongs_to :company
  has_many :applied_jobs,dependent: :destroy

  validates :company_image, presence: true
  validates :company_name, presence: true
  validates :description, presence: true
  validates :title, presence: true
  validates :expiry_date, presence: true
  validates :location, presence: true
  validates :experience_level, presence: true
  validates :no_of_applicants, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

end
