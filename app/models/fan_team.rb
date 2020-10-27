class FanTeam < ApplicationRecord
  has_many :users

  validates :team_name, presence: true
end
