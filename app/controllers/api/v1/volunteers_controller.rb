module Api
    module V1
        class VolunteersController < ApplicationController
            before_action :authorize_request

            def index
                volunteers = Volunteer.all
                render json: volunteers
            end

            # Add a volunteer to a request
            # POST: /api/v1/volunteers
            def create
                # when volunteers are upto 5 automatically mark the requset as fulfilled else create the volunteer
                num_of_volunteers = Volunteer.where(request_id: params[:request_id])
                if num_of_volunteers && num_of_volunteers.length() <= 4
=begin
                    num_of_person      num_of_volunteers array
                        1                     0
                        2                     1
                        3                     2
                        4                     3
                        5                     4
=end
                    if num_of_volunteers == 4
                    # if the num_of_volunteers is 4 this means the person volunteering is the 5th person
                    # so we update the request status to fulfilled
                        the_request = Request.find_by_id(params[:request_id])
                        the_request.status = 1
                        the_request.save
                    end

                    # prevent duplicate volunteering
                    duplicate = Volunteer.where(user_id: @current_user.id, request_id: params[:request_id])
                    if duplicate.any? 
                            render json: {
                                status: 'warning',
                                message: 'You have already volunteered for this request',
                            },
                            status: :ok
                    else
                        # if no duplicate then create the volunteer
                        volunteer = Volunteer.new({request_id: params[:request_id], requester_id: params[:requester_id], user_id: @current_user.id})
                        if volunteer.save
                            render json: {
                                status: 'success',
                                message:  'Your volunteering was successful',
                                data: volunteer,
                            },
                            status: :ok
                        else
                            render json: {
                                status: 'error',
                                message: 'Volunteering not saved',
                                data: volunteer.errors
                            },
                            status: :unprocessable_entity
                        end
                    end
                else
                    render json: {
                        status: 'warning',
                        message: 'The request has been fulfilled'
                    },
                    status: :ok
                end
            end

            # get all a users volunteerings
            # GET: /api/v1/my-volunteerings
            def my_volunteerings
                volunteering = Volunteer.where(user_id: @current_user.id)
                if volunteering
                    render json: volunteering, :include => {
                        :request => {
                            :only => [:id, :title, :reqtype, :description, :lat, :lng, :address, :status]
                        }
                    },
                    status: :ok
                else
                    render json: {
                        status: 'no content',
                        message: 'No volunteering found'
                    },
                    status: :no_content
                end
            end


        end
    end
end