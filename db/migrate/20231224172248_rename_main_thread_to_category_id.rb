class RenameMainThreadToCategoryId < ActiveRecord::Migration[7.1]
  def change
    rename_column :main_threads, :category, :category_id
  end
end
