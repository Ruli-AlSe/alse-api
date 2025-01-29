class Job < ApplicationRecord
  enum job_type: {
    part_time: 1,
    full_time: 2,
    freelance: 3
  }

  belongs_to :profile
  has_many :skills, as: :skillable

  # validations
  validates :title, :location, :job_type, :company_name, :activities, presence: true
end
