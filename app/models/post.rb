class Post < ApplicationRecord
  acts_as_taggable
  validates :title, presence: true,length: { maximum: 100 }
  validates :body, presence: true,length: { maximum: 500 }
  validates :deadline, presence: true
  validates :status, inclusion: { in: [true, false] }
  validates :user, presence: true
  validate :deadline_cannot_be_in_the_past

  belongs_to :user
  has_many :post_images, dependent: :destroy, foreign_key:'post_id'
  has_many :comments, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  def self.search(search,status)
    if search
      if status
        #キーワード入っていてチェックボックス入ってる時（false含め全件取得）
       Post.where(['title LIKE ?', "%#{search}%"])
      else
        #キーワード入っていてチェックボックスチェックない時、trueのみ表示（募集中のみ表示）
       Post.where(['title LIKE ?', "%#{search}%"]).where(status: true)
      end
    else
      if status
        #キーワードなくてチェックある時、全件取得
       Post.all
      else
        #キーワードなくてチェックない時、trueのみ取得（募集中のみ表示）
       Post.where(status: true)
      end
    end
  end

  def self.select_best_comment(best_comment_id,post_id)
    post = Post.find(post_id)
    post.update(best_comment_id: best_comment_id,status: false)
    comment=Comment.find(best_comment_id)
    comment.update(best_flag: true)
  end

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, ": 過去の日付は使用できません")
    end
  end

end
