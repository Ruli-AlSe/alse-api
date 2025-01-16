class Education < ApplicationRecord
  belongs_to :profile

  # validations
  validates :school_name, :career, :is_course, :relevant_topics, presence: true
end
