class HistorySerializer < ActiveModel::Serializer
    attributes :history

    def history
        records = []

        records.concat(
            object.main_threads.map do |main_thread|
                {
                activity: "post",
                created_at: main_thread.created_at,
                main_thread_id: main_thread.id
                }
            end
        )
        
        records.concat(
            object.comments.map do |comment|
                {
                activity: "comment",
                created_at: comment.created_at,
                main_thread_id: comment.main_thread_id
                }
            end
        )
        
        records.concat(
            object.likes.map do |like|
                {
                activity: "like",
                created_at: like.created_at,
                main_thread_id: like.main_thread_id
                }
            end
        )

        records
    end
end