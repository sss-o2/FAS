class AddDeleateFlagToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :deleate_flag, :boolean, default: false
  end
end
