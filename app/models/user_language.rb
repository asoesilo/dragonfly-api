class UserLanguage < ActiveRecord::Base
  belongs_to :profile
  belongs_to :language
  belongs_to :proficiency
  belongs_to :action

  validates :profile_id, presence: true, uniqueness: { scope: [:language_id, :proficiency_id, :action_id] }
  validates :language_id, presence: true
  validates :proficiency_id, presence: true
  validates :action_id, presence: true
end