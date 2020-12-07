class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image, dependent: :destroy

  validates :image, presence: true
  validate :image_validation

  # 画像・動画の拡張子を制限する
  def image_validation
    if image.attached? && !(image.content_type.match?(/png|jpeg|gif|mp4/))
      errors.add(:image, "は(.png .jpg .gif .mp4)から選択してください")
    end
  end
end
