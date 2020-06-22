class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :post_images, dependent: :destroy, foreign_key:'comment_id'
  has_many :favorites, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end 

end
