class PostImage < ApplicationRecord
  belongs_to :post
  belongs_to :comment

  attachment :image
end
