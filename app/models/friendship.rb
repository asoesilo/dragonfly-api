class Friendship < ActiveRecord::Base
  belongs_to :user1, class_name: :User, foreign_key: :user1_id
  belongs_to :user2, class_name: :User, foreign_key: :user2_id

  validates :user1_id, presence: true
  validates :user2_id, presence: true
  validate :not_friend_with_self
  validate :no_duplicate

  class << self
    def find_friendship(user1, user2)
      Friendship.where(["(user1_id = :user_id AND user2_id = :other_user_id) OR (user1_id = :other_user_id AND user2_id = :user_id)", {user_id: user1.id, other_user_id: user2.id}]).first
    end
  end

  private
  def not_friend_with_self
    if user1 === user2
      errors.add(:user2, "can't be friend with self")
    end
  end

  def no_duplicate
    if Friendship.find_friendship(user1, user2)
      errors.add(:user2, "friendship already exist")
    end
  end
end