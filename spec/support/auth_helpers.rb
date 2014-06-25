module AuthHelpers
  def auth_with_user(user)
    request.headers["Authorization"] = "#{user.id}"
  end

  def clear_token
    request.headers["Authorization"] = nil
  end
end