class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :introduce
      t.string :hp_url
      t.string :address
      t.integer :icon_image_id
      t.timestamps
    end
  end
end
