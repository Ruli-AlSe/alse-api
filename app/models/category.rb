class Category < ApplicationRecord
  has_many :posts
  belongs_to :company

  # validations
  validates :title, :description, :slug, presence: true
  validates :slug, uniqueness: { scope: :company_id }
end
