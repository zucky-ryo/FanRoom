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
    @open_message = OpenMessage.new
    @open_messages = @open_room.open_messages.includes(:user)
  end

  private

  def open_room_params
    params.require(:open_room_team).permit(:name, :description, fan_team_id: [:id]).merge(user_id: current_user.id)
  end
end
