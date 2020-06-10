class Post < ApplicationRecord
  acts_as_taggable
  validates :title, presence: { message: 'タイトルを入力してください' }
  validates :body, presence: { message: '本文を入力してください' }
  validates :deadline, presence: { message: '募集期間を入力してください' }
  validates :status, inclusion: { in: [true, false] }
  validates :user, presence: true

  belongs_to :user
  attachment :image
end
