class Skill < ApplicationRecord
  enum level: {
    basic: 1,
    intermediate: 2,
    conversational: 3,
    advanced: 4,
    native: 5
  }

  belongs_to :category
  belongs_to :profile

  # validations
  validates :name, presence: true

  def self.grouped_by_category(skills)
    skills.group_by { |skill| skill.category.title }
  end
end
