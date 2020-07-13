class Profile < ApplicationRecord
  belongs_to :user
  attachment :icon_image

  geocoded_by :address
  after_validation :geocode
end
