class OpenRoom < ApplicationRecord
  has_many :open_room_users
  has_many :users, through: :open_room_users
  has_many :open_messages
  has_many :open_room_fan_teams
  has_many :fan_teams, through: :open_room_fan_teams
end
