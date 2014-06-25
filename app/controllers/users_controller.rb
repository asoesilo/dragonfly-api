class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    User.transaction do
      @user = User.new(user_params)
      @user.is_online = true

      if @user.save
        languages = languages_params
        if languages["languages"]
          languages["languages"].each do |language|
            @user.languages.build(
              language_id: language["language_id"],
              proficiency_id: language["proficiency_id"],
              action_id: language["action_id"],
              start_date: language["start_date"]
              )
            raise Exceptions::InvalidUserLanguageError.new(@user.errors.full_messages) unless @user.save
          end
        end
      else
        raise Exceptions::InvalidUserError.new(@user.errors.full_messages)
      end
    end
    
    render json: @user, status: :ok
  end

  def details
    render json: current_user, status: :ok
  end

  def update
    if current_user.update_attributes(user_params)
      head :ok
    else
      raise Exceptions::InvalidUserError.new(current_user.errors.full_messages)
    end
  end

  def destroy
    if current_user.destroy
      send_offline_notice
      #TODO logout
      head :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :bad_request
    end
  end

  def matches
  end

  def online
  end

  def offline
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :firstname, :lastname, :birthday, :gender_id, :about)
  end

  def languages_params
    params.permit(languages: [:language_id, :proficiency_id, :action_id, :start_date])
  end

  def send_offline_notice
  end
end