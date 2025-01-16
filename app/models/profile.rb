class Profile < ApplicationRecord
  belongs_to :profilable, polymorphic: true
  has_many :skills, dependent: :destroy
  has_many :educations, dependent: :destroy
  has_many :jobs, dependent: :destroy

  # custom types
  attribute :social_media, SocialMediaType.new

  # validations
  validates :profilable_id, uniqueness: { scope: :profilable_type }
end
