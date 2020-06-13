class Post < ApplicationRecord
  acts_as_taggable
  validates :title, presence: { message: 'タイトルを入力してください' }
  validates :body, presence: { message: '本文を入力してください' }
  validates :deadline, presence: { message: '募集期間を入力してください' }
  validates :status, inclusion: { in: [true, false] }
  validates :user, presence: true

  belongs_to :user
  has_many :post_images, dependent: :destroy, foreign_key:'post_id'
  has_many :comments, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
end
