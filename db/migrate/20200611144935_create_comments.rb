class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :post_id, null: false
      t.integer :user_id, null: false
      t.string :image_id
      t.timestamps
    end
  end
end
