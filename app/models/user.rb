class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true, uniqueness: { case_sensitive: true }, length: { maximum: 20 }

  belongs_to :fan_team
  # こちらからフォローしているユーザー（中間テーブルとUsersテーブル）
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow, dependent: :destroy
  # フォローされているユーザー（中間テーブルとUsersテーブル）
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_relationships, source: :user, dependent: :destroy

  has_many :open_room_users
  has_many :open_rooms, through: :open_room_users, dependent: :destroy
  has_many :open_messages, dependent: :destroy

  has_many :private_room_users
  has_many :private_rooms, through: :private_room_users, dependent: :destroy
  has_many :private_messages, dependent: :destroy

  has_many :tweets
  has_many :comments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: "は半角英数字で入力してください", on: :create

  # フォロー時のメソッド（フォロー済みの場合findを返す）
  def follow(other_user)
    if self != other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # フォロー解除時のメソッド
  def unfollow(other_user)
    following_user = self.relationships.find_by(follow_id: other_user.id)
    following_user.destroy if following_user
  end

  # 引数のユーザーを既にフォローしているかを判別する
  def following?(other_user)
    self.followings.include?(other_user)
  end
end
