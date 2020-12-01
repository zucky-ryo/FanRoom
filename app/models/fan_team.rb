class FanTeam < ApplicationRecord
  has_many :users
  has_many :open_room_fan_teams
  has_many :open_rooms, through: :open_room_fan_teams

  validates :team_name, presence: true
end
