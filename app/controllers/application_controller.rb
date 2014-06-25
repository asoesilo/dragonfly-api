class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  before_action :authenticate_user

  rescue_from Exceptions::ApplicationError, with: :application_error_handling

  protected
  def current_user
    @current_user ||= User.find(current_user_id) if current_user_id
  end

  def log_in(user)
    # TODO
  end

  def log_out
    # TODO
  end

  private
  def authenticate_user
    unless current_user
      render json: { errors: ["user needs to be logged in"] }, status: :forbidden
    end
  end

  def application_error_handling(error)
    render json: { errors: error.messages }, status: :bad_request
  end

  def current_user_id
    request.headers["Authorization"]
  end
end
