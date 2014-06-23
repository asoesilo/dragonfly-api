class Friend < ActiveRecord::Base
  belongs_to :user1, class_name: :User, foreign_key: :user1_id
  belongs_to :user2, class_name: :User, foreign_key: :user2_id

  validates :user1_id, presence: true
  validates :user2_id, presence: true, uniqueness: {scope: :user1_id}
  validate :not_friend_with_self

  private
  def not_friend_with_self
    if user1 === user2
      errors.add(:user2, "can't be friend with self")
    end
  end
end