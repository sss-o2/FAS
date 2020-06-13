class ChangeDataImageIdToComments < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :image_id, 'integer USING CAST(image_id AS integer)'
  end
end
