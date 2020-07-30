class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers:[:google_oauth2]
  
  before_create :build_default_profile
    
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile
  has_many :favorites, dependent: :destroy
  has_many :favorite_comments, through: :favorites, source: 'comment'
  
  accepts_nested_attributes_for :profile

  validates :name, 
    uniqueness: { case_sensitive: :false },
    length: { minimum: 4, maximum: 20 }, 
    :presence => true

  def self.from_omniauth(auth)
    find_or_initialize_by(provider: auth["provider"], uid: auth["uid"]) do |user|
        user.provider = auth["provider"]
        user.uid = auth["uid"]
        user.name = auth["info"]["name"]
        user.email = auth["info"]["email"]
    end
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"]) do |user|
        user.attributes = params
      end
    else
      super
    end
  end

  #パスワードのバリデーション実行条件(uidがあれば実行)
  def password_required?
    if uid.present?
      false
    else
      super
    end      
  end
  
  private
  def build_default_profile
      build_profile
      true
  end
end
