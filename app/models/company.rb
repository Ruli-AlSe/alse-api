class Company < ApplicationRecord
  has_one :owner
  has_many :employees
  has_many :products

  # validations
  validates :name, presence: true
end
