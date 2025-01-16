class Education < ApplicationRecord
  belongs_to :profile

  # validations
  validates :school_name, :career, :relevant_topics, presence: true
end
