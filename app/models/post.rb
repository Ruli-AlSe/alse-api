class Post < ApplicationRecord
  # custom types
  attribute :credits, CreditsType.new

  #callbacks
  acts_as_paranoid

  #relations
  belongs_to :company

  # Validations
  validates :title, :content, :image_url, :company_id, presence: true
end
