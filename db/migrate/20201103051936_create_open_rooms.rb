class CreateOpenRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :open_rooms do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
