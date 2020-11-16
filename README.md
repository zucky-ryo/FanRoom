# テーブル設計

## usersテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| nickname | string     | null: false                    |
| email    | string     | null: false                    |
| password | string     | null: false                    |
| profile  | text       |                                |
| birthday | date       |                                |
| fan_team | references | null: false, foreign_key: true |

### Association

has_many :relationships
has_many :open_rooms, through: :open_room_users
has_many :open_room_users
has_many :open_messages
has_many :private_rooms, through: :private_room_users
has_many :private_room_users
has_many :private_messages
has_many :tweets
has_many :comments
belongs_to :fan_team

## relationshipsテーブル

| Column | Type       |Options                                     |
| ------ | ---------- |--------------------------------------------|
| user   | references | null: false, foreign_key:true              |
| follow | references | null: false, foreign_key: {to_table::users}|

### Association

belongs_to :user
belongs_to :follow, class_name: 'User'

## open_roomsテーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| name          | string | null: false |
| description   | text   | null: false |

### Association

has_many :users, through: :open_room_users
has_many :open_room_users
has_many :open_messages
has_many :fan_teams, through: :open_room_fan_teams
has_many :open_room_fan_teams

## open_room_usersテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| open_room | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :open_room

## open_messagesテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| open_room | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :open_room

## private_roomsテーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| name          | string | null: false |
| description   | text   | null: false |

### Association

has_many :users, through: :private_room_users
has_many :private_room_users
has_many :private_messages

## private_room_usersテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| private_room | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :private_room

## private_messagesテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| content      | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| private_room | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :private_room

## tweetsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |

### Association

belongs_to :user
has_many :comments
has_many :fan_teams, through: :tweet_fan_teams
has_many :tweet_fan_teams

## commentsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| tweet  | references | null: false, foreign_key: true |

### Association

belongs_to :user
belongs_to :tweet

## fan_teamsテーブル

| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| team_name | string | null: false |

### Association

has_many :users
has_many :tweets, through: :tweet_fan_teams
has_many :tweet_fan_teams
has_many :open_rooms, through: :open_room_fan_teams
has_many :open_room_fan_teams

## open_room_fan_teamsテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| open_room | references | null: false, foreign_key: true |
| fan_team  | references | null: false, foreign_key: true |

### Association

belongs_to :open_room
belongs_to :fan_team

## tweet_fan_teamsテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| tweet    | references | null: false, foreign_key: true |
| fan_team | references | null: false, foreign_key: true |

### Association

belongs_to :tweet
belongs_to :fan_team