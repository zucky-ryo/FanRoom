FactoryBot.define do
  factory :user do
    id { 1000 }
    nickname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { "test1111" }
    password_confirmation { password }
    association :fan_team
  end
end
