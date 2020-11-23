FactoryBot.define do
  factory :private_message do
    content { Faker::Lorem.sentence }
    association :user
    association :private_room
  end
end
