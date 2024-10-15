class Api::V1::AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def signin
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encoded(user_id: user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, time: time.strftime("%m-%d-%Y %H:%M"), user: user }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def signup
    user = User.new(signup_params)
    if user.save
      render json: { message: "User created successfully", user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :role)
  end
end
