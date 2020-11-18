class PrivateRoomsController < ApplicationController
  def index
    @private_rooms = current_user.private_rooms.joins(:private_messages).includes(:users, :private_messages).order("private_messages.id DESC")
    @my_open_rooms = current_user.open_rooms.joins(:open_messages).includes(:users, :open_messages).order("open_messages.id DESC")
  end

  def new
    @private_room = PrivateRoomMember.new
    @followings = current_user.followings.includes(:relationships).order("relationships.created_at DESC")
  end

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

  private

  def private_room_params
    params.require(:private_room_member).permit(:name, :description, user_ids: [])
  end

  def private_room_update_params
    params.require(:private_room).permit(:name, :description)
  end
end
