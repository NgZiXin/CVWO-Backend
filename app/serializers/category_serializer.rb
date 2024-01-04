class CategorySerializer < ActiveModel::Serializer
  attributes :id, :category
  has_many :main_threads
end
