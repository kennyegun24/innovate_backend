class Api::V1::WorkExperienceController < ApplicationController
    def create
        @WorkExp = current_user.work_experiences.new(work_params)

        if @WorkExp.save
            render json: {status: 'Successful', message: 'Work Experience Added'}, status: 201
        else
            render json: {status: 'Failure', message: 'Something went wrong'}, status: 422
        end
    end

    def index
        @user_work = current_user.work_experiences

        render json: {status: 'Successful', message: 'Work Experience Added', data: @user_work}, status: 201
    end

    def work_params
        params.require(:work_experience).permit(:company_name, :title, :description, :start_date, :end_date)
    end
end
