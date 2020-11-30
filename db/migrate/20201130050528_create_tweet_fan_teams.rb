class CreateTweetFanTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :tweet_fan_teams do |t|
      t.references :tweet, foreign_key: true
      t.references :fan_team, foreign_key: true
      t.timestamps

      t.index [:tweet_id, :fan_team_id], unique: true
    end
  end
end
