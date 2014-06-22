FactoryGirl.define do
  factory :action do
    name { Faker::Lorem.word }
  end
end