class OpenRoomUser < ApplicationRecord
  belongs_to :user
  belongs_to :open_room
end
