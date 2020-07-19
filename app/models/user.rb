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

  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  
  private
  def build_default_profile
      build_profile
      true
  end
end
