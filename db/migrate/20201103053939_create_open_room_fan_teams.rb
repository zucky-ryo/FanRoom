class CreateOpenRoomFanTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :open_room_fan_teams do |t|
      t.references :open_room, foreign_key: true
      t.references :fan_team, foreign_key: true
      t.timestamps

      t.index [:open_room_id, :fan_team_id], unique: true
    end
  end
end
