class Category < ApplicationRecord
  has_many :posts
  belongs_to :company

  validates :title, :description, :slug, presence: true
end
