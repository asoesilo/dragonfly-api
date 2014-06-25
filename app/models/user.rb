class User < ActiveRecord::Base
  has_secure_password
  belongs_to :gender
  has_many :languages, foreign_key: :user_id, class_name: :UserLanguage, dependent: :destroy

  has_attached_file :avatar, styles: {medium: '300x300>', thumb: '100x100>'}

  default_value_for :is_online, false

  validates :email, presence: true, uniqueness: true, email: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates_attachment :avatar, presence: true, content_type: {content_type: /\Aimage\/.*\Z/}, default_url: "/images/:style/missing.jpeg"

  def teaching_languages
    # TODO:
    languages.find_by(action: Action.TEACH)
  end

  def learning_languages
    # TODO:
    languages.find_by(action: Action.LEARN)
  end

  def as_json(options)
    {
      id: id,
      email: email,
      firstname: firstname,
      lastname: lastname,
      birthday: birthday.strftime("%F"),
      gender: gender.description,
      about: about,
      is_online: is_online
    }
  end
end
