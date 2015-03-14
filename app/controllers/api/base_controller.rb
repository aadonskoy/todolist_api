class API::BaseController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  before_action :authorize_by_token

  private

  def authorize_by_token
    return render(json: '{"error": "Api key missing"}', status: 401) unless params[:api_key]
    @current_user = User.by_token(params[:api_key]).first
    return render(json: '{"error": "Api key wrong"}', status: 401) unless @current_user
  end
end
