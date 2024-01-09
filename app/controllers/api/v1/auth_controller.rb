class Api::V1::AuthController < ApplicationController
    skip_before_action :authenticated, only: %i[ login ]
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    # GET /me
    def me 
        render json: current_user, serializer: MeSerializer, status: :ok
    end 

    # GET /me/history
    def history 
        render json: current_user, serializer: HistorySerializer, status: :ok
    end 

    # POST /login
    def login 
        @user = User.find_by!(username: login_params[:username])
        if @user.authenticate(login_params[:password])
            @token = encode_token(user_id: @user.id)
            render json: {
                user: UserSerializer.new(@user),
                token: @token
            }, status: :accepted
        else
            render json: { message: 'Incorrect password' }, status: :unauthorized
        end
    end

    private 

    # Only allow a list of trusted parameters through.
    def login_params 
        params.permit(:username, :password)
    end

    def handle_record_not_found(e)
        render json: { message: "User doesn't exist" }, status: :unauthorized
    end
end
