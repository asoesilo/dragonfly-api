class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.new(user_params)
    user.is_online = true
    if user.save
      render json: user, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def details
    render json: current_user, status: :ok
  end

  def update
    if current_user.update_attributes(user_params)
      head :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    if current_user.destroy
      send_offline_notice
      log_out
      head :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :bad_request
    end
  end

  def matches
  end

  def friends
  end

  def online
  end

  def offline
  end

  private
  def user_params
    # TODO: add teaching and learning languages association
    params.require(:user).permit(:email, :password, :firstname, :lastname, :birthday, :gender_id, :about)
  end

  def send_offline_notice
  end
end