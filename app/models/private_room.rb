class PrivateRoom < ApplicationRecord
  has_many :private_room_users
  has_many :users, through: :private_room_users, dependent: :destroy
  has_many :private_messages, dependent: :destroy

  validates :name, presence: true
end
