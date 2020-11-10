class OpenRoomsController < ApplicationController
  def index
    @open_rooms = OpenRoom.includes(:users)
  end

  def new
    @open_room = OpenRoomTeam.new
  end

  def create
    @open_room = OpenRoomTeam.new(open_room_params)
    if @open_room.valid?
      @open_room.save
      redirect_to open_rooms_path
    else
      render :new
    end
  end

  def show
    @open_room = OpenRoom.find(params[:id])
    @users = @open_room.users
    @open_message = OpenMessage.new
    @open_messages = @open_room.open_messages.includes(:user)
  end

  def edit
    @open_room = @open_room = OpenRoom.find(params[:id])
    @users = @open_room.users
  end

  def update
    @open_room = @open_room = OpenRoom.find(params[:id])
    @users = @open_room.users
    if @open_room.update(open_room_update_params)
      redirect_to open_room_path(@open_room.id)
    else
      render :edit
    end
  end

  # 今見てるチャットルームに参加する
  def add_member
    OpenRoomUser.find_or_create_by(user_id: current_user.id, open_room_id: params[:id])
  end

  private

  def open_room_params
    params.require(:open_room_team).permit(:name, :description, fan_team_id: [:id]).merge(user_id: current_user.id)
  end

  def open_room_update_params
    params.require(:open_room).permit(:name, :description)
  end
end
