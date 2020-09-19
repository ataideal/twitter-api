FactoryBot.define do
  factory :user_follow do
    association :user
    association :following, factory: :user
  end
end
