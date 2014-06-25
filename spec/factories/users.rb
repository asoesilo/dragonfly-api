FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { 20.years.ago }
    about { Faker::Lorem.paragraph }
    avatar { File.new("#{Rails.root}/spec/fixtures/images/avatar.jpeg") }
    association :gender
  end

  factory :user2, class: User do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { 20.years.ago }
    about { Faker::Lorem.paragraph }
    avatar { File.new("#{Rails.root}/spec/fixtures/images/avatar.jpeg") }
    association :gender
  end

  factory :user_without_avatar, class: User do
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    birthday { 20.years.ago }
    about { Faker::Lorem.paragraph }
    association :gender
  end
end