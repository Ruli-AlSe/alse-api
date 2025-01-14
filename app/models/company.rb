class Company < ApplicationRecord
  has_one :owner
  has_many :employees
  has_many :posts
  has_many :categories

  # validations
  validates :name, presence: true
end
