class Api::V1::AuthController < ApplicationController
    skip_before_action :authenticated, only: %i[ login logout]
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
            cookies.signed[:jwt] = { value:  @token, httponly: true, secure: true, domain: :all,same_site: :none }
            cookies[:user_id] = { value: @user.id.to_s, secure: true, domain: :all,same_site: :none }
            render json: {
                user: UserSerializer.new(@user),
            }, status: :accepted
        else
            render json: { message: 'Incorrect password' }, status: :unauthorized
        end
    end

    # DELETE /logout
    def logout
        cookies.delete(:jwt, domain: :all)
        cookies.delete(:user_id, domain: :all)
        render json: nil, status: :ok
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
