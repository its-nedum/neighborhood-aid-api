module Api
    module V1
        class UsersController < ApplicationController
            # get all users
            def index
                user = User.order('id ASC')
                render json: {
                    status: 'success',
                    message: 'All users',
                    data: user,
                    code: 200
                }
            end

            # register a user
            def create
                user = User.new(user_params)
                if user.save
                    render json: {
                        status: 'success',
                        message: 'User created',
                        data: user,
                        code: 201
                    }
                else 
                    render json: {
                        status: 'error',
                        message: 'User not created',
                        data: user.errors,
                        code: 422
                    }
                end
            end

            # login a user
            def login
                render json: {
                    status: 'success',
                    message: 'Login reached',
                    code: 200
                }
            end
            
            private
            def user_params
                params.permit(:firstname, :lastname, :email, :password, :image)
            end

        end
    end
end