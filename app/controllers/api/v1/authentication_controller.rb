class Api::V1::AuthenticationController < ApplicationController
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

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password)
  end

end
