class Friend < ActiveRecord::Base
  belongs_to :profile1, class_name: :Profile, foreign_key: :profile1_id
  belongs_to :profile2, class_name: :Profile, foreign_key: :profile2_id

  validates :profile1_id, presence: true
  validates :profile2_id, presence: true, uniqueness: {scope: :profile1_id}
  validate :not_friend_with_self

  private
  def not_friend_with_self
    if profile1 === profile2
      errors.add(:profile2, "can't be friend with self")
    end
  end
end