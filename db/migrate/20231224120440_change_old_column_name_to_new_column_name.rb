class ChangeOldColumnNameToNewColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :comments, :thread_id, :main_thread_id
  end
end
