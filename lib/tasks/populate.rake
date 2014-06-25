namespace :db do
  desc "Erase and fill database with testing data"
  task populate: :environment do
    require 'faker'

    [User, UserLanguage].each(&:delete_all)

    NUM_DAYS_IN_TEN_YEARS = 3650
    MALE = Gender.find_by(description: "Male")
    FEMALE = Gender.find_by(description: "Female")

    def get_random_date(days = NUM_DAYS_IN_TEN_YEARS)
      rand(days).days.ago(Date.today)
    end

    def get_random_gender
      # (rand < 0.5) ? MALE : FEMALE
      Gender.find(rand(Gender.count) + 1)
    end

    def get_random_language
      Language.find(rand(Language.count) + 1)
    end

    def get_random_proficiency
      Proficiency.find(rand(Proficiency.count) + 1)
    end

    def get_random_action
      Action.find(rand(Action.count) + 1)
    end

    def get_next_user(user)
      next_user = User.where(["id > :user_id", {user_id: user.id}]).first
      if next_user.nil?
        next_user = User.where(["id < :user_id", {user_id: user.id}]).first
      end
      next_user
    end

    20.times do
      user = User.new
      user.firstname = Faker::Name.first_name
      user.lastname = Faker::Name.last_name
      user.email = Faker::Internet.email(user.firstname)
      user.password = Faker::Lorem.word
      user.birthday = get_random_date
      user.gender_id = get_random_gender.id
      user.about = Faker::Lorem.paragraph
      user.save

      6.times do
        language = get_random_language
        proficiency = get_random_proficiency
        action = get_random_action
        start_date = get_random_date((Date.today - user.birthday).round)
        user.languages.create(
          language: language,
          proficiency: proficiency,
          action: action,
          start_date: start_date
          )
      end
    end

    User.all.each do |current_user|
      next_user = current_user
      3.times do
        next_user = get_next_user(next_user)
        break unless next_user
        Friendship.create(
          user1: current_user,
          user2: next_user
          )
      end
    end
  end
end