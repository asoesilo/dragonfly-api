class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user

  rescue_from Exceptions::ApplicationError, with: :application_error_handling

  protected
  def current_user
    @current_user ||= Profile.find(session[:user_id]) if session[:user_id]
  end

  private
  def authenticate_user
    unless current_user
      render json: { error: "user needs to be logged in" }, status: :forbidden
    end
  end

  def application_error_handling(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end
