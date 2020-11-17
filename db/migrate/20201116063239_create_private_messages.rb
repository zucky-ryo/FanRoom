class CreatePrivateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :private_messages do |t|
      t.text :content, null: false
      t.references :user, foreign_key: true
      t.references :private_room, foreign_key: true
      t.timestamps
    end
  end
end
