class Product < ApplicationRecord
  acts_as_paranoid

  belongs_to :company

  # Validations
  validates :name, :description, :price, :company_id, presence: true
end
