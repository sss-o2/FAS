class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id, null: false
      t.text :introduce
      t.string :hp_url
      t.string :address
      t.integer :icon_image_id
      t.timestamps
    end
  end
end
