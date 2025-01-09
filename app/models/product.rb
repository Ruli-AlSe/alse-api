class Product < ApplicationRecord
  belongs_to :store

  # Validations
  validates :name, :description, :price, :store_id, presence: true
end
