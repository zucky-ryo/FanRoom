FactoryBot.define do
  factory :private_room_user do
    association :user
    association :private_room
  end
end
