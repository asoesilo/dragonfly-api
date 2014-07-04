class UserLanguage < ActiveRecord::Base
  belongs_to :user
  belongs_to :language
  belongs_to :action

  validates :user_id, presence: true, uniqueness: { scope: [:language_id, :action_id] }
  validates :language_id, presence: true
  validates :proficiency, presence: true
  validates :action_id, presence: true

  def as_json(options)
    {
      id: id,
      language: language.as_json(options),
      proficiency: proficiency,
      action: action.as_json(options)
    }
  end
end