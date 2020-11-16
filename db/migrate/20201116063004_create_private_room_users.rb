class CreatePrivateRoomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :private_room_users do |t|
      t.references :user, foreign_key: true
      t.references :private_room, foreign_key: true
      t.timestamps

      t.index [:user_id, :private_room_id], unique: true
    end
  end
end
