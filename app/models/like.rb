class Like < ApplicationRecord
    belongs_to :main_thread
    belongs_to :user
    validates :main_thread, uniqueness: { scope: :user_id, message: "No more than one like per user" }
end
