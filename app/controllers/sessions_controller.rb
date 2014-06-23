class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create, :destroy]

  def create
    profile = Profile.find_by(email: params[:email])
    if profile && profile.authenticate(params[:password])
      session[:user_id] = profile.id
      head :ok
    else
      raise Exceptions::AuthenticationError.new, 'invalid username/password combination'
    end
  end

  def destroy
    if current_user
      reset_session
    end
    head :ok
  end
end