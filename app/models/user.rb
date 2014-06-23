class User < ActiveRecord::Base
  has_secure_password
  belongs_to :gender
  has_many :languages, foreign_key: :user_id, class_name: :UserLanguage, dependent: :destroy
  default_value_for :is_online, false

  validates :email, presence: true, uniqueness: true, email: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  def teaching_languages
    # TODO:
  end

  def learning_languages
    # TODO:
  end

  def as_json(options)
    {
      id: id,
      email: email,
      firstname: firstname,
      lastname: lastname,
      birthday: birthday,
      gender: gender.description,
      about: about,
      is_online: is_online
    }
  end
end
