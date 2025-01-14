class Category < ApplicationRecord
  has_many :posts

  validates :title, :description, :slug, presence: true
end
