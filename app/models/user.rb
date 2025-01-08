class User < ApplicationRecord
  has_secure_password

  # validations
  validates :email, :password_digest, :type, :age, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[\W+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 18, less_than_or_equal_to: 100 }
end
