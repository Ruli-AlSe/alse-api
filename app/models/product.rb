class Product < ApplicationRecord
  acts_as_paranoid
  
  belongs_to :store

  # Validations
  validates :name, :description, :price, :store_id, presence: true
end
