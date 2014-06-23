FactoryGirl.define do
  factory :friend do
    association :user1, factory: :user
    association :user2, factory: :user2
  end
end