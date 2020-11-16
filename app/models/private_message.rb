class PrivateMessage < ApplicationRecord
  belongs_to :user
  belongs_to :private_room
end
