class Api::V1::CompaniesController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create login]

  # api/v1/companies
  def create
    # Transaction to prevent company creation if company details fails to be saved
    ActiveRecord::Base.transaction do
      @company = Company.create(company_params)

      if @company.save
        @company_details = @company.build_company_detail(company_details_params)
        if @company_details.save
          token = encode_token(company_id: @company.id)
          render json: {
            status: 'success',
            message: 'Company created',
            data: {
              token: token,
              company_id: @company.id,
              type: 'company'
            }
          }, status: 201
        else
          # Rollback if company details couldn't be saved
          render json: {
            status: 'Error',
            message: @company_details.errors.full_messages
          },  status: 422
          raise ActiveRecord::Rollback
        end
      else
        render json: {
          status: 'Error',
          message: @company.errors.full_messages
        }, status: 422
      end
    end
  end

  # api/v1/companies/login
  def login
    @company = Company.find_by(email: params[:email])

    if @company&.authenticate(params[:password])
      token = encode_token(company_id: @company.id)
      render json: {
        status: 'Success',
        message: 'Logged in successfully',
        data: {
          token: token,
          company_id: @company.id,
          type: 'company'
        }
      }, status: 200
    else
      render json: {
        status: 'Error',
        message: 'Invalid Email or Password'
      },  status: 401
    end
  end

  def company_params
    params.require(:company).permit(:email, :password)
  end

  def company_details_params
    params.require(:company_detail).permit(:company_name, :capacity, :about)
  end

end
