class UserLanguage < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  belongs_to :action

  validates :user_id, presence: true, uniqueness: { scope: [:language_id, :action_id] }
  validates :language_id, presence: true
  validates :proficiency, presence: true
  validates :action_id, presence: true
end