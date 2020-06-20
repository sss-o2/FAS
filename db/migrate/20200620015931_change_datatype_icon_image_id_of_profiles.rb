class ChangeDatatypeIconImageIdOfProfiles < ActiveRecord::Migration[6.0]
  def change
    change_column :profiles, :icon_image_id, :string
  end
end
