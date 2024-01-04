class MeSerializer < ActiveModel::Serializer
    attributes :id, :username, :bio, :country
end