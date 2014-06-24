class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: user, status: :ok
    else
      raise Exceptions::AuthenticationError.new, 'invalid username/password combination'
    end
  end

  def destroy
    log_out
    head :ok
  end
end