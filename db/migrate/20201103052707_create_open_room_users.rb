class CreateOpenRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :open_room_users do |t|
      t.references :user, foreign_key: true
      t.references :open_room, foreign_key: true
      t.timestamps

      t.index [:user_id, :open_room_id], unique: true
    end
  end
end
