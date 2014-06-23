FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { 20.years.ago }
    about { Faker::Lorem.paragraph }
    gender { Gender.find_by(description: 'Male') }
  end

  factory :user2, class: User do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { 20.years.ago }
    about { Faker::Lorem.paragraph }
    gender { Gender.find_by(description: 'Female') }
  end
end