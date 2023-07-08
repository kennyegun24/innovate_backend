class Api::V1::Auth::WorkExperienceController < ApplicationController
    def create
        @WorkExp = current_user.work_experiences.new(work_params)

        if @WorkExp.save
            render json: {status: 'Successful', message: 'Work Experience Added'}, status: 201
        else
            render json: {status: 'Failure', message: @WorkExp.errors.full_messages}, status: 422
        end
    end

    def index
        @user_work = current_user.work_experiences.order(start_date: :desc)

        render json: {status: 'Successful', message: 'Work Experience', data: @user_work}, status: 200
    end

    def update
        @experience = current_user.work_experiences.find(params[:id])

        if @experience.update(update_params)
            render json: {status: 201, message: 'Work experience successfully updated'}, status: 201
        else
            render json: {status: 422, message: 'Error'}, status: 422
        end
    end

    def work_params
        params.require(:work_experience).permit(:company_name, :title, :description, :start_date, :end_date)
    end
    def update_params
        params.permit(:company_name, :title, :description, :start_date, :end_date)
    end
end
