class AddBestCommentIdToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :best_comment_id, :integer
  end
end
