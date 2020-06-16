class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :post_images, dependent: :destroy, foreign_key:'post_id'
  attachment :image
  accepts_attachments_for :post_images, attachment: :image
end
