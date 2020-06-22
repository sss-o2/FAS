class AddCommentsToBestFlag < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :best_flag, :boolean, default: false
  end
end
