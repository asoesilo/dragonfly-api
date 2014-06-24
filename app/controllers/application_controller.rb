class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_headers
  before_action :authenticate_user

  rescue_from Exceptions::ApplicationError, with: :application_error_handling

  protected
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    reset_session
  end

  private
  def authenticate_user
    unless current_user
      render json: { errors: ["user needs to be logged in"] }, status: :forbidden
    end
  end

  def application_error_handling(error)
    render json: { errors: [error.message] }, status: :bad_request
  end

  def set_headers
    headers["Access-Control-Allow-Origin"] = ENV["CLIENT_PATH"]
    headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, HEAD"
    headers["Access-Control-Max-Age"] = "86400"
  end
end
