class ApplicationController < ActionController::API
    include ::ActionController::Cookies
    before_action :authenticated

    def encode_token(payload)
        JWT.encode(payload, 'cvwoSecretKey') 
    end

    def decoded_token
        token = cookies.signed[:jwt]
        if token
            begin
                JWT.decode(token, 'cvwoSecretKey', true, algorithm: 'HS256')
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user 
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def authenticated
        unless !!current_user
        render json: { message: 'Please log in' }, status: :unauthorized
        end
    end
end
