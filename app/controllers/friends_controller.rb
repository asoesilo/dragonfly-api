class FriendsController < ApplicationController
  before_action :validate_parameters, only: [:create, :destroy]

  def create
    user2 = User.find(params[:id])

    friend = Friend.new(
      user1: current_user,
      user2: user2
      )

    if friend.save
      head :ok
    else
      raise Exceptions::InvalidFriendCreationError.new(friend.errors.full_messages)
    end
  end

  def destroy
    friend = User.find(params[:id])
    friend_relation = Friend.find_friendship(current_user, friend)

    if friend_relation
      raise Exceptions::InvalidFriendDestroyError.new(friend_relation.errors.full_messages) unless friend_relation.destroy
    end

    head :ok
  end

  private
  def validate_parameters
    if params[:id].nil?
      raise Exceptions::InvalidParametersError.new(["Friend ID cannot be empty"])
    end
  end
end