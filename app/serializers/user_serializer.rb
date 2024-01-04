class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :bio, :country
    # has_many :threads
    # has_many :comments
    # has_many :likes
end