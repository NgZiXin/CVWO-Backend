class LikeSerializer < ActiveModel::Serializer
  attributes :id, :main_thread_id, :user_id
  belongs_to :main_thread
  belongs_to :user
end
