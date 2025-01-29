class Project < ApplicationRecord
  belongs_to :company
  has_many :skills, as: :skillable

  # validations
  validates :name, :description, :company_name, :live_url, :repository_url, presence: true
end
