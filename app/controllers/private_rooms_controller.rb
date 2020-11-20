class PrivateRoomsController < ApplicationController
  before_action :authenticate_user!

  # ルームをルーム内で送信されたメッセージが新しい順に表示
  def index
    @private_rooms = current_user.private_rooms.joins(:private_messages).includes(:users, :private_messages).order("private_messages.id DESC")
    @my_open_rooms = current_user.open_rooms.joins(:open_messages).includes(:users, :open_messages).order("open_messages.id DESC")
  end

  def new
    @private_room = PrivateRoomMember.new
    @followings = current_user.followings.includes(:relationships).order("relationships.created_at DESC")
  end

  # フォームオブジェクトにてルーム作成
  def create
    @private_room = PrivateRoomMember.new(private_room_params)
    @private_room.user_ids.push(current_user.id)
    if @private_room.valid?
      @private_room.save
      # ルーム作成後に作成したルームに遷移しメッセージを自動送信する
      private_room_id = PrivateRoom.all[-1].id
      PrivateMessage.create(content: "ルームを作成しました", user_id: current_user.id, private_room_id: private_room_id)
      redirect_to private_room_path(private_room_id)
    else
      @followings = current_user.followings.includes(:relationships).order("relationships.created_at DESC")
      render :new
    end
  end

  def show
    @private_room = PrivateRoom.find(params[:id])
    @users = @private_room.users
    @private_message = PrivateMessage.new
    @private_messages = @private_room.private_messages.includes(:user)
    # メンバー追加時の選択リストから参加ずみのユーザーを除くため
    @followings = current_user.followings.includes(:relationships).order("relationships.created_at DESC").select do |user|
      @users.include?(user) == false
    end
  end

  def edit
    @private_room = PrivateRoom.find(params[:id])
    @users = @private_room.users
  end

  # ルーム名とルームメモの更新のみのためフォームオブジェクトは利用しない
  def update
    @private_room = PrivateRoom.find(params[:id])
    @users = @private_room.users
    if @private_room.update(private_room_update_params)
      redirect_to private_room_path(@private_room.id)
    else
      render :edit
    end
  end

  # ルームにメンバーを追加する
  def add_member
    room_id = add_member_params[:private_room_id]
    add_member_params[:user_ids].each do |user_id|
      PrivateRoomUser.create(user_id: user_id, private_room_id: room_id)
    end
    redirect_to private_room_path(room_id)
  end

  # ルームから退出し、ルームメンバーが0になったらルームを自動的に削除する
  def exit
    @private_room = PrivateRoom.find(params[:id])
    @private_room_user = PrivateRoomUser.find_by(private_room_id: params[:id], user_id: current_user.id)
    if @private_room_user.destroy
      if @private_room.users.length == 0
        @private_room.destroy
      end
      redirect_to private_rooms_path
    end
  end

  # 他ユーザーの詳細ページからそのユーザーとのチャットをすぐに生成する(既存の場合はそのルームに遷移)
  def simple_chat
    other_user = User.find(params[:format])
    room = PrivateRoom.includes(:users).select do |room|
      room.users.include?(current_user) && room.users.include?(other_user) && room.users.length == 2
    end
    if room.length == 0
      private_room = PrivateRoom.create(name: "", description: "")
      PrivateRoomUser.create(user_id: current_user.id, private_room_id: private_room.id)
      PrivateRoomUser.create(user_id: params[:format], private_room_id: private_room.id)
      PrivateMessage.create(content: "ルームを作成しました", user_id: current_user.id, private_room_id: private_room.id)
      redirect_to private_room_path(private_room.id)
    else
      redirect_to private_room_path(room[0].id)
    end
  end

  private

  def private_room_params
    params.require(:private_room_member).permit(:name, :description, user_ids: [])
  end

  def private_room_update_params
    params.require(:private_room).permit(:name, :description)
  end

  def add_member_params
    params.permit(user_ids: []).merge(private_room_id: params[:id])
  end
end
