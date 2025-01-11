class User < ApplicationRecord
  has_secure_password
  belongs_to :company
  has_many :tokens

  # nested attributes
  accepts_nested_attributes_for :company

  # validations
  validates :email, :password_digest, :type, :age, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 18, less_than_or_equal_to: 100 }
  validates_inclusion_of :type, in: %w[Owner Employee]
end
