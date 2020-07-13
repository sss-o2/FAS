class AddColumnToProfiles < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :latitude, :float
    add_column :profiles, :longitude, :float
  end
end
