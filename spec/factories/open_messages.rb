FactoryBot.define do
  factory :open_message do
    content { Faker::Lorem.sentence }
    association :user
    association :open_room
  end
end
