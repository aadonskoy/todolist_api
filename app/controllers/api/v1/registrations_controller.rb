class API::V1::RegistrationsController < API::BaseController
  skip_before_action :authorize_by_token, only: [:create]
  def create
    user = User.new(user_params)
    if user.save
      render json: user.as_json(email: user.email), status: 201
    else
      render json: user.errors, status: 422
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end
