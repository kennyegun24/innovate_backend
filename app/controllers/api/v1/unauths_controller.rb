class Api::V1::UnauthsController < ApplicationController
    skip_before_action :authenticate_request, only: %i[show]

  ## Show current user details in user profile
  def show #api/v1/unauhs/:id
    @user = User.find(params[:id])

    @user_details = {
          name: @user.name,
          username: @user.user_name,
          email: @user.email,
          image: @user.image,
          header: @user.header,
          bio: @user.bio,
          about: @user.about,
          profession: @user.profession,
          location: @user.location,
          blogs_count: @user.blogs_count,
          posts_count: @user.posts_count,
          website1: @user.website1,
          website2: @user.website2,
          website3: @user.website3,
          phoneNumber: @user.phoneNumber,
          school: @user.school,
          company: @user.company,
          work: @user.work,
          start_date: @user.start_date,
      }

    if @user
      render json: {status: 'Success', message: 'User', data: @user_details}, status: 200
      else
        render json: {status: 'Fail', message: 'Wrong Details'}, status: 422
    end
  end

end
