class CreatePostImages < ActiveRecord::Migration[6.0]
  def change
    create_table :post_images do |t|
      t.string :image_id
      t.timestamps
    end
  end
end
