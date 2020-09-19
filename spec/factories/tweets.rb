FactoryBot.define do
  factory :tweet do
    user
    content { Faker::Lorem.sentence }
  end
end
