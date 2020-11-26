class ApplicationController < ActionController::API

    def not_found
        render json: { error: 'not_found'}
    end

    def authorize_request
        header = request.headers['Authorization']
        if header
            header = header.split(' ').last 
            begin
                @decoded = decode_token(header)
                @current_user = User.find(@decoded[:user_id])
            rescue ActiveRecord::RecordNotFound => e
                render json: { errors: e.message }, status: :unauthorized
            rescue JWT::DecodeError => e
                render json: { errors: e.message }, status: :unauthorized
            end
        else 
            render json: { error: 'No authorization token found' }, status: :unauthorized
        end
    end

    private
    # token decode secret
    SECRET_KEY = Rails.application.secrets.secret_key_base. to_s

    # token decoder method
    def decode_token(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
    end
end
