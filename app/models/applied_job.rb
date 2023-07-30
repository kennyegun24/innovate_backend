class AppliedJob < ApplicationRecord
  belongs_to :job
  belongs_to :user

  after_save :update_number_of_aplicants

  def update_number_of_aplicants
    self.job.update(no_of_applicants: self.job.applied_jobs.count)
  end

end
