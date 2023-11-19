class Api::V1::WorkExperienceController < ApplicationController
  skip_before_action :authenticate_request, only: %i[other_user_experience]

  def other_user_experience
    @experience = WorkExperience.where(user: params[:id])

    render json: {status: 201, message: 'Work experience', data: @experience}, status: 200
  end
end
