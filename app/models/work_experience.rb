class WorkExperience < ApplicationRecord
    belongs_to :user
    validates :company_name, presence: true
    validates :title, presence: true
    validates :description, length: {maximum: 500}
    validates :start_date, presence: true
end
