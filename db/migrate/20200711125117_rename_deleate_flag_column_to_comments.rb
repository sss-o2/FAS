class RenameDeleateFlagColumnToComments < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :deleate_flag, :delete_flag
  end
end
