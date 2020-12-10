module Api
    module V1
        class RequestsController < ApplicationController
            before_action :authorize_request

            # Get all the request [Any request with status of 1 (fulfilled) should not be displayed]
            # GET: /api/v1/requests
            def index
                requests = Request.where(status: 0)
                render json: {
                    status: 'success',
                    message: 'All requests',
                    data: requests,
                },
                status: :ok
            end
         
            # Make a new the request 
            # POST: /api/v1/requests
            def create
                request = Request.new({title: params[:title], reqtype: params[:reqtype], description: params[:description],
                    lat: params[:lat], lng: params[:lng], address: params[:address], status: params[:status], user_id: @current_user.id})
                if request.save
                    render json: {
                        status: 'success',
                        message: 'Request added successfully',
                        data: request
                    },
                    status: :created
                else 
                    render json: {
                        status: 'error',
                        message: 'Request not saved',
                        data: request.errors
                    },
                    status: :unprocessable_entity
                end
            end

            # Get a single request with the user that made the request [including the volunteers]
            # GET: /api/v1/requests/:id
            def show
                request = Request.includes(:user).find_by_id(params[:id])
                if request
                    render json: request, :include => {
                        :user => {
                            :only => [:id, :firstname, :lastname, :email]
                        },
                        :volunteers => {
                            :only => [:id, :user_id, :created_at],
                            :include => {
                                :user => {
                                    :only => [:id, :firstname, :lastname, :email]
                                }
                            }
                        }
                    },
                    status: :ok
                else 
                    render json: {
                        status: 'error',
                        message: 'Request not found',
                    },
                    status: :unprocessable_entity
                end
            end


            # Get request of a particular  user
            # GET: /api/v1/my-requests
            def my_request
                request = Request.where(user_id: @current_user.id)
                if request
                    render json: {
                        status: 'success',
                        message: '',
                        data: request,
                    },
                    status: :ok
                else 
                    render json: {
                        status: 'error',
                        message: 'Requests not found',
                    },
                    status: :unprocessable_entity
                end
            end


            private
            def request_params
                params.permit(:title, :reqtype, :description, :lat, :lng, :address, :status)
            end

        end
    end
end