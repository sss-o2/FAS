class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :post_images, dependent: :destroy
  attachment :image

end
