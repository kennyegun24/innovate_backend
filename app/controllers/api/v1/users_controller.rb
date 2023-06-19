class Api::V1::UsersController < ApplicationController
    skip_before_action :authenticate_request, only: %i[create login]

  def create #api/v1/users
    @user = User.create(user_params)

    if @user.save
      token = encode_token(user_id: @user.id)
      render json: {status: 'success', message: 'User created', data: {token: token }}, status: 201
    else
      render json: { status: 'Error', message: @user.errors.full_messages }, status: 422
    end
  end

  def login #api/v1/user/login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = encode_token(user_id: @user.id)
      render json: {status: 'Success', message: 'Logged in successfully', data: {token: token, user_id: @user.id} },status: 200
    else
      render json: { status: 'Error', message: 'Invalid Email or Password' },status: 401
    end
  end

  ## Show other user details for authenticated users
  def show #api/v1/users/:id
    @user = User.find(params[:id])

    @isFollowed = @user.followers.pluck(:follower_user_id).include?(current_user.id)

    @user_details = {
      name: @user.name,
      username: @user.user_name,
      email: @user.email,
      image: @user.image,
      header: @user.header,
      bio: @user.bio,
      about: @user.about,
      id: @user.id,
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

    final_obj = {
      **@user_details.symbolize_keys,
      isFollowed: @isFollowed
    }

    render json: {status: 'Successful', message: 'user', data: final_obj}, status: 200
  end

  ## Show other user details
  def get_profile #api/v1/user/profile
    @user = {
      name: current_user.name,
      username: current_user.user_name,
      email: current_user.email,
      image: current_user.image,
      header: current_user.header,
      bio: current_user.bio,
      about: current_user.about,
      profession: current_user.profession,
      location: current_user.location,
      blogs_count: current_user.blogs_count,
      posts_count: current_user.posts_count,
      website1: current_user.website1,
      website2: current_user.website2,
      website3: current_user.website3,
      phoneNumber: current_user.phoneNumber,
      school: current_user.school,
      company: current_user.company,
      work: current_user.work,
      start_date: current_user.start_date,
      id: current_user.id
    }
    render json: {status: 'Success', message: 'User details', data: @user},status: 200
  end

  ## Update user profile
  def update_profile #api/v1/user/update_profile
    @user_update = current_user.update(update_params)

    if @user_update
      render json: {status: 'success', message: 'Details saved', data: 'saved'}, status: 201
    else
      render json: { status: 'Error', message: @user_update.errors.full_messages }, status: 422
    end
  end

  # method to delete user
  def destroy
    current_user.destroy
  end

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password)
  end

  def update_params
    params.require(:user).permit(:name, :header, :bio, :about, :profession, :location, :website1, :website2, :website3, :phoneNumber, :school, :company, :work, :start_date)
  end
end
