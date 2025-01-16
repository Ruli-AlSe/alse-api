class Post < ApplicationRecord
  # custom types
  attribute :credits, CreditsType.new

  # callbacks
  acts_as_paranoid

  # relations
  belongs_to :company
  belongs_to :category

  # Validations
  validates :title, :content, :image_url, :slug, :company_id, presence: true
end
