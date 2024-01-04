class MainThread < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :comments
    has_many :likes
    validates :title, presence: {message: "is missing"}, length: { maximum: 200 }
    validates :body, presence: {message: "is missing"}
    validates :category_id, presence: {message: "is missing"}
end
