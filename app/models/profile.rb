class Profile < ApplicationRecord
  belongs_to :profilable, polymorphic: true
  has_many :skills, dependent: :destroy

  # nested attributes
  accepts_nested_attributes_for :skills

  # custom types
  attribute :social_media, SocialMediaType.new

  # validations
  validates :profilable_id, uniqueness: { scope: :profilable_type }
end
