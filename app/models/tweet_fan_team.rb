class TweetFanTeam < ApplicationRecord
  belongs_to :tweet
  belongs_to :fan_team
end
