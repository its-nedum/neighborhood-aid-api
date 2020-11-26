module Api
    module V1
        class UsersController < ApplicationController
            before_action :authorize_request, except: [:create, :login]

            # get all users
            def index
                user = User.order('id ASC')
                render json: {
                    status: 'success',
                    message: 'All users',
                    data: user,
                },
                status: :ok
            end

            # register a user
            def create
                user = User.new(user_params)
                if User.exists?(email: params[:email])
                    render json: {
                        status: 'warning',
                        message: 'User already exists',
                    },
                    status: :unprocessable_entity
                else
                    if user.save
                        token = encode_token({user_id: user.id, firstname: user.firstname, lastname: user.lastname, email: user.email})
                        render json: {
                            status: 'success',
                            message: 'User created',
                            data: user,
                            token: token,
                        },
                        status: :created
                    else 
                        render json: {
                            status: 'error',
                            message: 'User not created',
                            data: user.errors,
                        },
                        status: :unprocessable_entity
                    end
                end
            end

            # login a user
            def login
                user = User.find_by_email(params[:email])
                if user&.authenticate(params[:password])
                    token = encode_token({user_id: user.id, firstname: user.firstname, lastname: user.lastname, email: user.email})
                    render json: {
                        status: 'success',
                        message: 'Login successful',
                        token: token,
                    },
                    status: :ok
                else
                    render json: {
                        status: 'error',
                        message: 'Incorrect email or password',
                    },
                    status: :unprocessable_entity
                end 
            end
            
            private
            def user_params
                params.permit(:firstname, :lastname, :email, :password, :image)
            end
            
            # token hash secret
            SECRET_KEY = Rails.application.secrets.secret_key_base. to_s
            
            # token generator method using the secret
            def encode_token(payload, exp = 24.hours.from_now)
            payload[:exp] = exp.to_i
            JWT.encode(payload, SECRET_KEY) 
            end

        end
    end
end