class Api::V1::Auth::CompanyDetailsController < ApplicationController
  # update method
  # show method to display current company details
  # create method to display other company details

  def show
    @company = Company.find_by(id: 1).as_json(include: [:company_detail])
    @company_details = {
      company_name: @company["company_detail"]["company_name"],
      capacity: @company["company_detail"]["capacity"],
      creation_date: @company["company_detail"]["creation_date"],
      about: @company["company_detail"]["about"],
      post_count: @company["company_detail"]["post_count"],
      followers_count: @company["company_detail"]["followers_count"],
      open_jobs: @company["company_detail"]["open_jobs"],
      company_image: @company["company_detail"]["company_image"],
      company_id: @company["company_detail"]["company_id"],
      header: @company["company_detail"]["header"],
      email: @company["email"]
    }
    render json: {
            status: 200, data:
            @company_details
          }, status: 200
  end
end
