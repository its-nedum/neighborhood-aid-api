module Api
    module V1
        class MessagesController < ApplicationController
            before_action :authorize_request

            # Send your first message to the requester that you can help them
            # POST: /api/v1/messages
            def create
                mesg = Message.new({user_id: @current_user.id, receiver_id: params[:receiver_id], content: params[:content], request_id: params[:request_id]})
                if mesg.save
                    render json: {
                        status: 'success',
                        message: 'Your message was sent',
                        data: mesg,
                    },
                    status: :created
                else
                    render json: {
                        status: 'error',
                        message: 'Message not sent',
                        data: mesg.errors
                    },
                    status: :unprocessable_entity
                end
            end

            # Get all requester messages from their volunteers
            # GET: /api/v1/my-messages
            def my_messages
                my_mesgs = Message.includes(:user).where(receiver_id: @current_user.id).order(created_at: :desc)
                if my_mesgs.any?
                    render json: my_mesgs, :include => {
                        :user => {
                            :only => [:id, :firstname, :lastname]
                        }
                    },
                    status: :ok
                else
                    render json: {
                        status: 'no-content',
                        message: 'You don\'t have any message yet',
                    },
                    status: :ok
                end
            end

            # Get a chat messages between the requester and volunteer including the request
            # GET: /api/v1/chat/:request_id
            def get_chat_messages
                chats = Message.includes(:user).where(receiver_id: @current_user.id, request_id: params[:request_id]).or(Message.includes(:user).where(user_id: @current_user.id, request_id: params[:request_id])).order(created_at: :asc)
                if chats.any?
                    render json: chats, :include => {
                        :user => {
                            :only => [:id, :firstname, :lastname]
                        },
                        :request => {
                            :only => [:id, :title, :reqtype, :status, :description, :created_at]
                        }
                    },
                    status: :ok
                else
                    render json: {
                        status: 'no-content',
                        message: 'No chat on this request yet'
                    },
                    status: :ok
                end
            end

        end
    end
end