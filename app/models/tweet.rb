class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :image, presence: true 
  validate :image_validation

  def image_validation
    unless image.content_type.match?(/png|jpeg|gif|mp4/)
      errors.add(:image, "は(.png .jpg .gif .mp4)から選択してください")
    end
  end
end
