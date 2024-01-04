class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :thread_id
      t.integer :user_id

      t.timestamps
    end
  end
end
