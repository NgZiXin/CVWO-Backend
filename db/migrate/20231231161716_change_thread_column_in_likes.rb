class ChangeThreadColumnInLikes < ActiveRecord::Migration[7.1]
  def change
    rename_column :likes, :thread_id, :main_thread_id
  end
end
