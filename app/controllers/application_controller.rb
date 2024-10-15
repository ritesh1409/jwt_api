class ApplicationController < ActionController::API
  include JwtToken

  before_action :authenticate_user!

  def authenticate_user!
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      @decode = JwtToken.decoded(header)
      @current_user = User.find(@decode[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unauthorized
    rescue
      render json: { error: e.message }, status: :unauthorized
    end
  end
end
