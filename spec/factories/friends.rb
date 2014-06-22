FactoryGirl.define do
  factory :friend do
    association :profile1, factory: :profile
    association :profile2, factory: :profile2
  end
end