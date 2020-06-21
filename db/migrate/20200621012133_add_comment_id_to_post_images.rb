class AddCommentIdToPostImages < ActiveRecord::Migration[6.0]
  def change
    add_reference :post_images, :comment, foreign_key: true
  end
end
