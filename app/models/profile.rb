class Profile < ApplicationRecord
  belongs_to :user

  # custom types
  attribute :social_media, SocialMediaType.new
end
