class OpenMessage < ApplicationRecord
  belongs_to :user
  belongs_to :open_room

  validates :content, presence: true
end
