# アプリケーション名

FanRoom

# アプリケーション概要

&emsp;プロ野球ファンのためのチャットアプリです。<br>
&emsp;全ユーザーに公開されるチャットルームを作成したり、既存のルームに入室し、不特定多数の人とリアルタイムでチャットをすることができます。また、非公開のプライベートチャットルームを作成し、特定の人とチャットをすることもできます。<br>
&emsp;お気に入りのユーザーがいればフォローすることができ、プライベートチャットルームにフォローリストからユーザーを追加することができます。

# 利用方法

&emsp;ユーザー登録前は、トップページと公開ルームを見ることができますが、参加やその他機能の実行にはログインが必要です。<br>
&emsp;公開チャットルーム一覧から、チームタグ検索やルーム名検索を利用して面白そうなルームを探し、入室します。この際、入室前にルーム内のチャットを見ることができます。入室後、チャットを送信できるようになり、ルームを退出したい場合は詳細から退出ボタンを押すとルームから退出することができます。また、自分で公開ルームを作成することができます。<br>
&emsp;参加チャット一覧から非公開のプライベートチャットルームを作成することができます。作成ボタンから作成ページに飛び、ルームに参加するユーザーをフォローリストから選び作成します。ルーム作成後は選んだメンバーとチャットができ、詳細から追加ボタンを押すとそのルームにメンバーを追加することができます。退出は公開チャットルームと同様です。<br>
&emsp;他ユーザーのページにフォローボタンがあり、そのユーザーをフォローすることができます。フォローしたユーザーは自分のフォローリストに追加され、自分のプライベートチャットルームに参加させることができるようになります。また、フォローしたユーザーのページには簡易ルーム作成のボタンがあり、その人と自分のみのプライベートチャットをすぐに作成することができます。ただし、既にその人と自分のみのチャットルームが存在する場合はそのルームに遷移します。フォロー解除ボタンを押すと、そのユーザーのフォローを解除することができます。

# URL

## AWS

http://52.197.109.116/

# テスト用アカウント

 - Email: test@gmail.com
 - Password: test1111

# 制作背景(意図)

&emsp;周りにプロ野球が好きな人がおらず、プロ野球について話ができない人や、1人で野球観戦をしているため、その時の感情を共感したり語ったりできない人達が、チャットで一緒に盛り上がれるようなアプリがあればいいなと思い、このアプリケーションの制作を考えました。

## ペルソナ
 - 性別・年齢：20代〜30代の男性
 - 職業：サラリーマン
 - 趣味：プロ野球観戦
 - 日頃の生活：仕事が終わり家に帰って、1人で野球観戦をしている。

## 課題
 - 同じチームのファン同士で会話がしたい
 - 野球観戦をしながらリアルタイムでチャットをしたい
 - 好きな選手の写真や試合風景の動画を投稿し、共有したい。

## 洗い出した要件
 - ユーザー機能：登録、編集、詳細、削除
 - ユーザーフォロー機能：フォロー、フォロー解除
 - 公開チャットルーム機能：一覧、作成、編集、詳細、検索、入室、退出、チャット送信
 - プライベートチャットルーム機能：一覧、作成、編集、詳細、メンバー追加、退出、簡易作成、チャット送信
 - 画像・動画投稿機能：一覧、作成、編集、詳細、削除、検索、コメント

# ページ遷移図
<img width="1038" alt="スクリーンショット 2020-11-26 17 38 32" src="https://user-images.githubusercontent.com/72057673/100328611-12536f80-3010-11eb-8618-1f322ccf0bc3.png">

# DEMO

## トップページ
&emsp;ヘッダーには各機能へのリンクと、ユーザー登録/ログインボタンがあり、トップページ内には各機能について簡単な説明が書いてあります。<br>

## ユーザー登録機能
&emsp;ニックネームと好きなチームを選択し、メールアドレスとパスワードを入力します。プロフィールと生年月日は空白でも登録できます。ニックネームとメールアドレスは重複したものが既にある場合、登録できません。また、全ての情報は後で編集することができます。<br>
&emsp;登録後やログイン後はマイページに遷移します。<br>

## フォロー機能
&emsp;他ユーザーのページにフォローボタンがあります。フォローした後や既にフォローしている場合はフォローボタンがフォロー解除ボタンに変わります。また、フォローはワンクリックで出来ますが、フォロー解除には確認フォームを表示させています。<br>
&emsp;各ユーザーのページにはフォローリストとフォロワーリストがあり、そのユーザーがフォローしている人やフォローされている人を見ることができます。<br>

## 公開チャットルーム一覧表示機能
&emsp;公開チャット一覧ページには、既に作成されているルームが一覧で表示されています。また、ルーム内のチャットが新しい順で上から表示されるため、アクティブなルームが常に上に来るようになります。<br>
&emsp;それぞれのルームには、ルーム名と参加人数、最新のチャットが送信された時間が表示されており、参加済みのルームにはルーム名の横に参加中という文字が表示されています。また、最新チャットが本日の場合のみ、日付の代わりにTodayという文字が表示されます。<br>

## 公開チャットルーム作成機能
&emsp;参加チャット一覧か公開チャット一覧のページにルーム作成ボタンがあります。ボタンを押すと作成ページに飛び、ルーム名と検索に利用されるチームタグを入力します。ルームメモは空白でも登録できます。また、ルーム名とルームメモは後で編集することができます。<br>
&emsp;作成後は作成したチャットルームのページに遷移し、ルームを作成しましたというメッセージが自動で送信されます。作成時のルームメンバーは自分のみですが、一覧ページに表示され、誰でも参加することができます。<br>

## 公開チャットルーム検索機能
&emsp;公開チャット一覧ページで2種類のルーム検索をかけることができます。<br>
&emsp;チームタグ検索は、セレクトボックスからチームを1つ選び、検索ボタンを押します。ボタンを押すと検索後の一覧ページに遷移し、ルーム作成時に登録されているチームタグに該当するルームのみを表示させることができます。<br>
&emsp;ルーム名検索は、検索フォームに文字を入力すると、入力した文字がルーム名に含まれているルームを即座に表示させることができます。<br>

## 公開チャットルーム詳細機能
&emsp;公開チャット一覧ページからルームを選択すると、そのルームのページに遷移します。ルーム未参加の場合はチャットを送信することはできませんが、ルーム内のチャットを見ることはできます。<br>
&emsp;参加ボタンを押すとそのルームに参加でき、チャットを送信できるようになります。また、右上の詳細ボタンを押すと、参加しているメンバーや登録されたチームタグ、ルームメモを見ることができます。詳細内の右上のボタンを押すと、ルーム名とルームメモの編集やそのルームから退出することができます。<br>

## 参加チャットルーム一覧表示機能
&emsp;参加チャット一覧ページには、自分が参加しているプライベートルームと公開ルームが、それぞれ左右に分かれて一覧で表示されています。また、ルーム内のチャットが新しい順で上から表示されるため、アクティブなルームが常に上に来るようになります。<br>
&emsp;それぞれのルームには、ルーム名と参加人数、最新のチャットが送信された時間が表示されています。また、最新チャットが本日の場合のみ、日付の代わりにTodayという文字が表示されます。<br>
&emsp;ルーム名が設定されていないプライベートルームには、ルーム名の代わりに自分以外のメンバーの名前が表示されます。また、ルームメンバーが自分だけになった場合はメンバーがいませんという文字が表示されます。<br>


## プライベートルーム作成機能
&emsp;参加チャット一覧ページにルーム作成ボタンがあります。ボタンを押すと作成ページに飛び、参加させるルームメンバーを自分のフォローリストから選択できます。ルーム名とルームメモは空白でも登録でき、ルーム名が空白の場合はルーム名の場所に自分以外のメンバーの名前が表示されます。また、ルーム名とルームメモは後で編集することができます。<br>
&emsp;作成後は作成したチャットルームのページに遷移し、ルームを作成しましたというメッセージが自動で送信されます。作成時のルームメンバーは選択したユーザーのみですが、後からメンバーを追加することができます。<br>

## プライベートルーム詳細機能
&emsp;参加チャットルーム一覧からルームを選択すると、そのルームのページに遷移し、チャットを送信できます。<br>
&emsp;右上の詳細ボタンを押すと、参加しているメンバーや、ルーム名、ルームメモを見ることができます。詳細内の右上のボタンを押すと、ルーム名とルームメモの編集やそのルームから退出することができます。<br>
&emsp;詳細内のメンバーリストの横にある追加ボタンを押すと、ユーザー選択フォームが表示され、自分がフォローしていてルーム未参加のユーザーが一覧で表示されます。ユーザーを選択し、ルームに追加を押すとユーザーをそのルームに参加させることができます。<br>

## プライベートルーム簡易作成機能
&emsp;フォロー済みのユーザーのページには、手紙の形をしたチャット作成ボタンが表示されています。ボタンを押すと確認メッセージが表示され、そのユーザーとのプライベートチャットルームをすぐに作成することができます。ただし、そのユーザーと自分のみのプラーベートチャットルームが既に存在している場合は、そのルームに遷移します。<br>

# 工夫した点と苦労した点

## 苦労した点
&emsp;技術面では、フォロー機能の実装に苦労しました。ユーザーモデル同士が多対多の関係になるため、架空のモデルを使用した中間テーブルの作成や、実際にフォローやフォロー解除をするためのメソッドをユーザーモデルに定義することが大変でした。<br>
&emsp;フォロー機能以外にも、JavaScriptを利用したルーム検索機能や、自動ルーム削除機能など、カリキュラムで勉強していないことを独学で勉強し、アプリケーションに実装することに苦労しました。<br>

## 工夫した点
&emsp;アプリケーションを利用するユーザーの視点に立ち、必要な機能を考えることを重視しました。例えば、チャットルームで自分や他ユーザーがチャットを送信した際に、自動でチャットルームの一番下にスクロールする機能を搭載しました。しかし、チャットを遡って見ている人がいきなり一番下にスクロールすると使い辛いため、現在位置が一番下にある場合のみ、自動スクロールをするように実装しました。<br>

# 実装予定の機能

画像・動画投稿機能

# ローカルでの動作方法

Rubyバージョン：ruby 2.6.5<br>
 - cd FanRoom
 - bundle install
 - yarn install
 - rails db:create
 - rails db:migrate
 - rails s

# 使用技術（開発環境）

## バックエンド
Ruby, Ruby on Rails

## フロントエンド
HTML/CSS, JavaScript

## データベース
MySQL, SequelPro

## インフラ
AWS(EC2)

## Webサーバー（本番環境）
Nginx

## アプリケーションサーバー
Unicorn

## ソース管理
GitHub, GitHubDesktop

## テスト
RSpec

## エディタ
VSCode

# データベース設計

## ER図

<img width="823" alt="er_dio" src="https://user-images.githubusercontent.com/72057673/100091298-c2ea3380-2e97-11eb-9478-f4f22442066a.png">

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

 - has_many :relationships
 - has_many :open_rooms, through: :open_room_users
 - has_many :open_room_users
 - has_many :open_messages
 - has_many :private_rooms, through: :private_room_users
 - has_many :private_room_users
 - has_many :private_messages
 - has_many :tweets
 - has_many :comments
 - belongs_to :fan_team

## relationshipsテーブル

| Column | Type       |Options                                     |
| ------ | ---------- |--------------------------------------------|
| user   | references | null: false, foreign_key:true              |
| follow | references | null: false, foreign_key: {to_table::users}|

### Association

 - belongs_to :user
 - belongs_to :follow, class_name: 'User'

## open_roomsテーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| name          | string | null: false |
| description   | text   | null: false |

### Association

 - has_many :users, through: :open_room_users
 - has_many :open_room_users
 - has_many :open_messages
 - has_many :fan_teams, through: :open_room_fan_teams
 - has_many :open_room_fan_teams

## open_room_usersテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |
| open_room | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - belongs_to :open_room

## open_messagesテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| content   | text       | null: false                    |
| user      | references | null: false, foreign_key: true |
| open_room | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - belongs_to :open_room

## private_roomsテーブル

| Column        | Type   | Options     |
| ------------- | ------ | ----------- |
| name          | string | null: false |
| description   | text   | null: false |

### Association

 - has_many :users, through: :private_room_users
 - has_many :private_room_users
 - has_many :private_messages

## private_room_usersテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| user         | references | null: false, foreign_key: true |
| private_room | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - belongs_to :private_room

## private_messagesテーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| content      | text       | null: false                    |
| user         | references | null: false, foreign_key: true |
| private_room | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - belongs_to :private_room

## tweetsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - has_many :comments
 - has_many :fan_teams, through: :tweet_fan_teams
 - has_many :tweet_fan_teams

## commentsテーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| tweet  | references | null: false, foreign_key: true |

### Association

 - belongs_to :user
 - belongs_to :tweet

## fan_teamsテーブル

| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| team_name | string | null: false |

### Association

 - has_many :users
 - has_many :tweets, through: :tweet_fan_teams
 - has_many :tweet_fan_teams
 - has_many :open_rooms, through: :open_room_fan_teams
 - has_many :open_room_fan_teams

## open_room_fan_teamsテーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| open_room | references | null: false, foreign_key: true |
| fan_team  | references | null: false, foreign_key: true |

### Association

 - belongs_to :open_room
 - belongs_to :fan_team

## tweet_fan_teamsテーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| tweet    | references | null: false, foreign_key: true |
| fan_team | references | null: false, foreign_key: true |

### Association

 - belongs_to :tweet
 - belongs_to :fan_team