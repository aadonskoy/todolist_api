class API::V1::SessionsController < API::BaseController
  skip_before_action :authorize_by_token, only: [:log_in]

  def log_in
    user = User.where(email: session_params['email']).first
    if user && user.valid_password?(session_params['password'])
      @api_key = user.generate_api_key
      render json: user.to_json(api_key: @api_key)
    else
      render json: '{"error": "User is not exist or password is invalid."}', status: 401
    end
  end

  def log_out
    @current_user.destroy_token
    render json: @current_user
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
