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

  def self.select_best_comment(best_comment)
    binding.pry
    post = Post.find(params[:id])
    post.update(best_comment_id: best_comment)
  end

end
