namespace :db do
  desc "Erase and fill database with testing data"
  task populate: :environment do
    require 'faker'

    [User, UserLanguage].each(&:delete_all)

    NUM_DAYS_IN_TEN_YEARS = 3650
    MALE = Gender.find_by(description: "Male")
    FEMALE = Gender.find_by(description: "Female")
    AVATAR = File.new("#{Rails.root}/spec/fixtures/images/avatar.jpeg")

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
      rand(1..10)
    end

    def get_random_action
      Action.find(rand(Action.count) + 1)
    end

    def get_next_user(user)
      next_user = User.where(["id > :user_id", {user_id: user.id}]).order(:id).first
      if next_user.nil?
        next_user = User.where(["id < :user_id", {user_id: user.id}]).order(:id).last
      end
      next_user
    end

    def get_prev_user(user)
      prev_user = User.where(["id < :user_id", {user_id: user.id}]).order(:id).last
      if prev_user.nil?
        prev_user = User.where(["id > :user_id", {user_id: user.id}]).order(:id).first
      end
      prev_user
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
      #user.avatar = AVATAR
      user.save

      2.times do
        language = get_random_language
        proficiency = get_random_proficiency
        start_date = get_random_date((Date.today - user.birthday).round)
        user.languages.create(
          language: language,
          proficiency: proficiency,
          action: Action.LEARN,
          start_date: start_date
          )
      end

      2.times do
        language = get_random_language
        proficiency = get_random_proficiency
        start_date = get_random_date((Date.today - user.birthday).round)
        user.languages.create(
          language: language,
          proficiency: proficiency,
          action: Action.TEACH,
          start_date: start_date
          )
      end
    end

    User.all.each do |current_user|
      prev_user = current_user
      3.times do
        prev_user = get_prev_user(prev_user)
        action = Action.TEACH

        # Add current user's language to learn to other user's language to teach
        userLanguage = current_user.languages_to_learn.sample
        if(prev_user.languages.find_by(language: userLanguage.language, action: action).nil?)
          proficiency = 10
          start_date = get_random_date((Date.today - prev_user.birthday).round)
          prev_user.languages.create(
            language: userLanguage.language,
            proficiency: proficiency,
            action: action,
            start_date: start_date
            )
        end

        # Add other user's language to learn to current user's language to teach
        userLanguage = prev_user.languages_to_learn.sample
        if(current_user.languages.find_by(language: userLanguage.language, action: action).nil?)
          proficiency = 10
          start_date = get_random_date((Date.today - current_user.birthday).round)
          current_user.languages.create(
            language: userLanguage.language,
            proficiency: proficiency,
            action: action,
            start_date: start_date
            )
        end
      end
    end

    User.all.each do |current_user|
      next_user = current_user
      1.times do
        next_user = get_next_user(next_user)
        break unless next_user
        Friendship.create(
          user1: current_user,
          user2: next_user
          )
      end

      prev_user = current_user
      1.times do
        prev_user = get_prev_user(prev_user)
        break unless prev_user
        Friendship.create(
          user1: current_user,
          user2: prev_user
          )
      end
    end
  end
end