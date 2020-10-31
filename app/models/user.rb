class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :nickname, presence: true

  belongs_to :fan_team
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "follow_id"
  has_many :followers, through: :reverse_relationships, source: :user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: "Include both letters and numbers", on: :create
end
