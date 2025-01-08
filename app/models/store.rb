class Store < ApplicationRecord
  has_one :owner
  has_many :employees

  # validations
  validates :name, presence: true
end
