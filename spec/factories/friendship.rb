FactoryGirl.define do
  factory :friendship do
    association :user1, factory: :user
    association :user2, factory: :user2
  end
end