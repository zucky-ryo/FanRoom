class OpenRoomTeam
  include ActiveModel::Model
  attr_accessor :name, :description, :user_id, :fan_team_id

  validates :name, presence: true, length: { maximum: 20 }
  validate :fan_team_validation

  def fan_team_validation
    if fan_team_id[0][:id] == ""
      errors.add(:fan_team_id, "can't be blank")
    end
  end

  # オープンルーム作成
  def save
    open_room = OpenRoom.create(name: name, description: description)

    OpenRoomUser.create(user_id: user_id, open_room_id: open_room.id)

    # １ルームに複数のチームを登録させるためのループ処理
    fan_team_id.each do |team_id|
      OpenRoomFanTeam.find_or_create_by(open_room_id: open_room.id, fan_team_id: team_id[:id].to_i)
    end
  end
end
