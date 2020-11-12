FactoryBot.define do
  factory :open_room_team do
    name { Faker::String.random(length: 10) }
    fan_team_id { [{ id: 1 }] }
  end
end
