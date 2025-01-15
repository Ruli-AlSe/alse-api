class Category < ApplicationRecord
  has_many :posts
  has_many :skills
  belongs_to :company

  # validations
  validates :title, :description, :slug, presence: true
  validates :slug, uniqueness: { scope: :company_id }
end
