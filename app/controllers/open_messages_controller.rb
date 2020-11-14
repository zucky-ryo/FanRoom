class OpenMessagesController < ApplicationController
  before_action :authenticate_user!
  
  # チャネルを利用してメッセージの送信を行う
  def create
    open_room = OpenRoom.find(params[:open_room_id])
    @open_message = OpenMessage.new(open_message_params)
    if params[:open_message][:content] != "" && open_room.users.include?(current_user) && @open_message.save
      ActionCable.server.broadcast "open_message_channel", content: @open_message, user: @open_message.user
    end
  end

  private

  def open_message_params
    params.require(:open_message).permit(:content).merge(user_id: current_user.id, open_room_id: params[:open_room_id])
  end
end
