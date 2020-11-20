class PrivateRoomMember
  include ActiveModel::Model
  attr_accessor :name, :description, :user_ids, :private_room_id

  validates :name, length: { maximum: 20 }
  validate :user_ids_validation

  def user_ids_validation
    if user_ids.length == 2
      errors.add(:user_ids, "を選択してください")
    end
  end

  # プライベートルーム作成
  def save
    private_room = PrivateRoom.create(name: name, description: description)

    # 複数のユーザーをプライベートルームに登録する
    user_ids.each do |user_id|
      PrivateRoomUser.create(user_id: user_id, private_room_id: private_room.id)
    end
  end
end
