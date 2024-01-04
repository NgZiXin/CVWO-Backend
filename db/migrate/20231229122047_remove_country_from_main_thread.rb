class RemoveCountryFromMainThread < ActiveRecord::Migration[7.1]
  def change
    remove_column :main_threads, :country, :string
  end
end
