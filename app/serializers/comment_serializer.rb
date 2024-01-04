class CommentSerializer < ActiveModel::Serializer
  attributes :id, :body, :user_id, :main_thread_id, :created_at, :updated_at
  belongs_to :user
  # belongs_to :main_thread
end
