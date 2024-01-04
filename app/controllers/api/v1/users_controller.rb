class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticated, only: %i[ index show create ]
    before_action :set_user, only: %i[ show update ]
    rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

    # GET /users
    def index
        @users = User.all
        render json: @users
    end

    # GET /users/1
    def show
        render json: @user
    end

    # POST /signup
    def create 
        user = User.create!(user_params)
        @token = encode_token(user_id: user.id)
        render json: {
            user: UserSerializer.new(user)
        }, status: :created
    end

    # PATCH /users/1
    def update
        if authorized?
            if @user.update(user_params)
                render json: @user
            else
                render json: { message: @user.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { message: 'Unauthorized to edit profile' }, status: :unauthorized
        end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    # Only allow authorized users to update profile
    def authorized?
        @user.id == current_user.id
    end

    # Only allow a list of trusted parameters through.
    def user_params 
        params.require(:user).permit(:username, :password, :bio, :country)
    end

    def handle_invalid_record(e)
            render json: { message: e.record.errors.full_messages }, status: :unprocessable_entity
    end

end
