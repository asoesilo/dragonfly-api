class FriendshipsController < ApplicationController
  before_action :validate_parameters, only: [:create, :destroy]

  def index
  end

  def create
    user2 = User.find(params[:id])

    friendship = Friendship.new(
      user1: current_user,
      user2: user2
      )

    if friendship.save
      head :ok
    else
      raise Exceptions::InvalidFriendshipCreationError.new(friendship.errors.full_messages)
    end
  end

  def destroy
    friend = User.find(params[:id])
    friendship = Friendship.find_friendship(current_user, friend)

    if friendship
      raise Exceptions::InvalidFriendshipDestroyError.new(friendship.errors.full_messages) unless friendship.destroy
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