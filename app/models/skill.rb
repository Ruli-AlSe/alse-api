class Skill < ApplicationRecord
  enum level: {
    basic: 1,
    intermediate: 2,
    conversational: 3,
    advanced: 4,
    native: 5
  }

  belongs_to :category
  belongs_to :skillable, polymorphic: true

  # validations
  validates :name, presence: true
end
