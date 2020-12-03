module Api
    module V1
        class RequestsController < ApplicationController
            before_action :authorize_request

            def index
                requests = Request.all
                render json: {
                    status: 'success',
                    message: 'All requests',
                    data: requests,
                },
                status: :ok
            end
         
            def create
                @request = Request.new({title: params[:title], reqtype: params[:reqtype], description: params[:description],
                    lat: params[:lat], lng: params[:lng], address: params[:address], status: params[:status], user_id: @current_user.id})
                if @request.save
                    render json: {
                        status: 'success',
                        message: 'Request added successfully',
                        data: @request
                    },
                    status: :created
                else 
                    render json: {
                        status: 'error',
                        message: 'Request not saved',
                        data: @request.errors
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