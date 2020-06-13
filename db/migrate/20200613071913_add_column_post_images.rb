class AddColumnPostImages < ActiveRecord::Migration[6.0]
  def change
    add_reference :post_images, :post, foreign_key: true
  end
end
