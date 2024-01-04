class MainThreadSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :category_id, :user_id, :created_at, :updated_at, :numLikes
  belongs_to :user
  # has_many :comments
  # has_many :likes

  def numLikes
    object.likes.length
  end
end
