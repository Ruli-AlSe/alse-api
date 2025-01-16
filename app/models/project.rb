class Project < ApplicationRecord
  belongs_to :company

  # validations
  validates :name, :description, :company_name, :live_url, :repository_url, presence: true
end
