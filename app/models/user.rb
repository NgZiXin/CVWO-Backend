class User < ApplicationRecord
    has_secure_password
    has_many :main_threads
    has_many :comments
    has_many :likes
    validates :username, presence: {message: "is missing"}, length: { maximum: 25 }
    validates :username, uniqueness: {message: "has been taken"}
    validates :password, presence: {message: "is missing"}, length: { minimum: 5 }, on: :create
end
