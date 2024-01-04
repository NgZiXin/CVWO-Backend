class Api::V1::MainThreadsController < ApplicationController
  skip_before_action :authenticated, only: %i[ index show get_comments get_likes ]
  before_action :set_main_thread, only: %i[ show get_comments get_likes update destroy ]

  # GET /main_threads
  def index
    @main_threads = MainThread.all

    render json: @main_threads
  end

  # GET /main_threads/1
  def show
    render json: @main_thread
  end

  # GET /main_threads/1/comments
  def get_comments
    render json: @main_thread.comments, include: ['user'] # overwrite AMS behaviour to obtain deeply nested data
  end

  # GET /main_threads/1/likes
  def get_likes
    render json: @main_thread.likes
  end

  # POST /main_threads
  def create
    @main_thread = MainThread.new(main_thread_params)
    @main_thread.user_id = current_user.id
    if @main_thread.save
      render json: @main_thread, status: :created, location: api_v1_main_threads_path(@main_thread)
    else
      render json: { message: @main_thread.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /main_threads/1
  def update
    if authorized?
      if @main_thread.update(main_thread_params)
        render json: @main_thread
      else
        render json: { message: @main_thread.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Unauthorized to update this thread' }, status: :unauthorized
    end
  end

  # DELETE /main_threads/1
  def destroy
    if authorized?
      @main_thread.destroy!
      render json: nil, status: :ok
    else
      render json: { message: 'Unauthorized to delete this thread' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_thread
      @main_thread = MainThread.find(params[:id])
    end

    # Only allow authorized users to delete/ update thread
    def authorized?
      @main_thread.user_id == current_user.id
    end

    # Only allow a list of trusted parameters through.
    def main_thread_params
      params.require(:main_thread).permit(:title, :body, :category_id, :user_id)
    end
end
