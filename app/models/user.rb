class User < ActiveRecord::Base
  has_secure_password
  has_one :gender
  has_many :languages, foreign_key: :user_id, class_name: :UserLanguage
  default_value_for :is_online, false

  validates :email, presence: true, uniqueness: true, email: true
  validates :firstname, presence: true
  validates :lastname, presence: true
end
