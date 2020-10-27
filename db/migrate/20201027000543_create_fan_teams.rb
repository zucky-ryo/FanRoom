class CreateFanTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :fan_teams do |t|
      t.string :team_name, null: false
      t.timestamps
    end
  end
end
