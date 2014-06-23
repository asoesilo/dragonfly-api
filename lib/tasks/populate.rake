namespace :db do
  desc "Erase and fill database with testing data"
  task populate: :environment do
    require 'faker'

    [User].each(&:delete_all)

    NUM_DAYS_IN_TEN_YEARS = 3650
    MALE = Gender.find_by(description: "Male")
    FEMALE = Gender.find_by(description: "Female")

    def get_random_date
      rand(NUM_DAYS_IN_TEN_YEARS).days.ago(Date.today)
    end

    def get_random_gender
      (rand < 0.5) ? MALE : FEMALE
    end

    # User.populate 20 do |user|
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
    end
  end
end