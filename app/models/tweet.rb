class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :tweet_fan_teams
  has_many :fan_teams, through: :tweet_fan_teams
end
