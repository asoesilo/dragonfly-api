class LanguagesController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]

  def index
    render json: Language.all, status: :ok
  end
end