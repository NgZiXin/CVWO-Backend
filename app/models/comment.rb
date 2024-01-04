class Comment < ApplicationRecord
    belongs_to :main_thread
    belongs_to :user
    validates :body, presence: {message: "is missing"}
end
