class Api::V1::LikesController < ApplicationController
    before_action :set_like, only: %i[ destroy ]

    # POST /likes
    def create
        @like = Like.new(like_params)
        if @like.save
            render json: @like, status: :created, location: api_v1_likes_path(@like)
        else
            render json: { message: @like.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /likes/1
    def destroy
        if authorized?
            @like.destroy!
            render json: nil, status: :ok
        else
            render json: { message: 'Unauthorized to unlike' }, status: :unauthorized
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_like
        @like = Like.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { message: 'Not Found' }, status: :not_found
    end

    # Only allow authorized users to delete likes
    def authorized?
        @like.user_id == current_user.id
      end
  
    # Only allow a list of trusted parameters through.
    def like_params
        params.require(:like).permit(:main_thread_id).merge(user_id: current_user.id)
    end

end
