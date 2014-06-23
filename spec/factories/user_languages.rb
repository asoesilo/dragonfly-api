FactoryGirl.define do
  factory :user_language do
    association :user
    association :language
    association :proficiency
    association :action
    start_date { 5.years.ago }
  end
end