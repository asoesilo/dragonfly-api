class User < ActiveRecord::Base
  has_secure_password
  belongs_to :gender
  has_many :user_languages
  has_many :languages, foreign_key: :user_id, class_name: :UserLanguage, dependent: :destroy

  #has_attached_file :avatar, styles: {medium: '300x300>', thumb: '100x100>'}

  default_value_for :is_online, false

  validates :email, presence: true, uniqueness: true, email: true
  validates :firstname, presence: true
  validates :lastname, presence: true

  #validates_attachment :avatar, content_type: {content_type: /\Aimage\/.*\Z/}, default_url: "/images/:style/missing.jpeg"

  def languages_to_teach
    languages.where(action: Action.TEACH)
  end

  def languages_to_learn
    languages.where(action: Action.LEARN)
  end

  def matches
    User.where(["id <> :user_id AND id IN (
        SELECT ul11.user_id FROM user_languages ul11 
        WHERE ul11.action_id = :learn AND ul11.language_id IN (
          SELECT ul12.language_id FROM user_languages ul12
          WHERE ul12.user_id = :user_id AND ul12.action_id = :teach)) AND
      id IN (
        SELECT ul21.user_id FROM user_languages ul21
        WHERE ul21.action_id = :teach AND ul21.language_id IN (
          SELECT ul22.language_id FROM user_languages ul22
          WHERE ul22.user_id = :user_id AND ul22.action_id = :learn)) AND
      id NOT IN (
        (SELECT f1.user1_id FROM friendships f1
          WHERE f1.user2_id = :user_id)
        UNION
        (SELECT f2.user2_id FROM friendships f2
          WHERE f2.user1_id = :user_id))", 
      {user_id: id, learn: Action.LEARN.id, teach: Action.TEACH.id}])
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
      is_online: is_online,
      languages: user_languages.as_json(options)
    }
  end
end
