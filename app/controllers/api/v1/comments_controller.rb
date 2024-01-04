class Api::V1::CommentsController < ApplicationController
  skip_before_action :authenticated, only: %i[ index show ]
  before_action :set_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @comments = Comment.all

    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      render json: @comment, status: :created, location: api_v1_comments_path(@comment)
    else
      render json: { message: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if authorized?
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: { message: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Unauthorized to update this comment' }, status: :unauthorized
    end
  end

  # DELETE /comments/1
  def destroy
    if authorized?
      @comment.destroy!
      render json: nil, status: :ok
    else
      render json: { message: 'Unauthorized to delete this comment' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow authorized users to delete/ update comment
    def authorized?
      @comment.user_id == current_user.id
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:body, :main_thread_id, :user_id)
    end
end
