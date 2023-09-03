class Company < ApplicationRecord
  has_secure_password
  has_one :company_detail
  has_many :jobs

  validates :email, presence: true, uniqueness: true
end
