class Profile < ApplicationRecord
  belongs_to :user
  attachment :icon_image
end
