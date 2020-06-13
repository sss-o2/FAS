class ChangeDataImageIdToPost < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :image_id, 'integer USING CAST(image_id AS integer)'
  end
end
