FactoryBot.define do
  factory :open_room_user do
    association :user
    association :open_room
  end
end
