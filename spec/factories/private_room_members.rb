FactoryBot.define do
  factory :private_room_member do
    name { Faker::String.random(length: 10) }
    user_ids { ["", 1, 2] }
  end
end
