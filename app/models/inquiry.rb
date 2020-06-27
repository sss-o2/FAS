class Inquiry < ApplicationRecord
  validates :email, presence: true
  validates :message, presence: true,length: { maximum: 500 }
  
end
