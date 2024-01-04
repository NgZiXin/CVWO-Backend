class CreateMainThreads < ActiveRecord::Migration[7.1]
  def change
    create_table :main_threads do |t|
      t.string :title
      t.text :body
      t.integer :category
      t.string :country
      t.integer :user_id

      t.timestamps
    end
  end
end
