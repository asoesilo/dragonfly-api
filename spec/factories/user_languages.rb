FactoryGirl.define do
  factory :user_language do
    association :user
    association :language
    association :action
    proficiency { rand(10) + 1 }
    start_date { 5.years.ago }
  end
end