class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :image_id
      t.integer :user_id, null: false
      t.boolean :status,default: true, null: false
      t.date :deadline,null: false
      t.timestamps
    end
  end
end
