class Api::V1::AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: %i[create login]

  def create #api/v1/users
    ActiveRecord::Base.transaction do
      @user = User.create(user_params)

      if @user.save
        @blog = @user.build_blog
        if @blog.save
          token = encode_token(user_id: @user.id)
          render json: {
            status: 'success',
            message: 'User created',
            data: {
              token: token,
              use_id: @user.id,
              type: 'individual'
            }
          }, status: 201
        else
          render json: {
            status: 'Error',
            message: @blog.errors.full_messages
          },  status: 422
          raise ActiveRecord::Rollback
        end
      else
        render json: { status: 'Error', message: @user.errors.full_messages }, status: 422
      end
    end
  end

  def login #api/v1/user/login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      token = encode_token(user_id: @user.id)
      render json: {status: 'Success', message: 'Logged in successfully', data: {token: token, user_id: @user.id, type: 'individual' } },status: 200
    else
      render json: { status: 'Error', message: 'Invalid Email or Password' },status: 401
    end
  end

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password)
  end

end
