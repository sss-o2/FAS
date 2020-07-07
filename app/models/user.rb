class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one :profile
  has_many :favorites, dependent: :destroy
  has_many :favorite_comments, through: :favorites, source: 'comment'
  
  accepts_nested_attributes_for :profile
  before_create :build_default_profile
  
  private
  def build_default_profile
      build_profile
      true
  end
end
