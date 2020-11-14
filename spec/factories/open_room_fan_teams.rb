FactoryBot.define do
  factory :open_room_fan_team do
    association :fan_team
    association :open_room
  end
end
