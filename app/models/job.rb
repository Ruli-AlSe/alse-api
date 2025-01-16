class Job < ApplicationRecord
  belongs_to :profile
  enum job_type: {
    part_time: 1,
    full_time: 2,
    freelance: 3
  }

  # validations
  validates :title, :location, :job_type, :company_name, :activities, presence: true
  validates :job_type, inclusion: { in: job_types.keys, message: "%{value} is not a valid job type" }
end
