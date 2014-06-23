module UserAccountHelpers
  module Macros
    def current_user(&user)
      let(:current_user, &user)
      before { login_as current_user }
    end

    def logged_out_user
      before { log_out }
    end

    def logged_in_user
      current_user { create(:profile) }
    end
  end

  def login_as(user)
    request.session[:user_id] = user.id
  end

  def log_out
    request.session[:user_id] = nil
  end
end