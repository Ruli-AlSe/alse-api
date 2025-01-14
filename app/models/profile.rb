class Profile < ApplicationRecord
  belongs_to :profilable, polymorphic: true

  # custom types
  attribute :social_media, SocialMediaType.new

  # validations
  validates :profilable_id, uniqueness: { scope: :profilable_type }
end
