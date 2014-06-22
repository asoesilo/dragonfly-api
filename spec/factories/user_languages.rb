FactoryGirl.define do
  factory :user_language do
    association :profile
    association :language
    association :proficiency
    association :action
    start_date { 5.years.ago }
  end
end