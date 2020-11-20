class PrivateMessagesController < ApplicationController
  before_action :authenticate_user!

  # チャネルを利用してメッセージの送信を行う
  def create
    private_room = PrivateRoom.find(params[:private_room_id])
    # ルームメンバーでない場合トップページに遷移
    redirect_to root_path unless private_room.users.include?(current_user)
    @private_message = PrivateMessage.new(private_message_params)
    if params[:private_message][:content] != "" && private_room.users.include?(current_user) && @private_message.save
      ActionCable.server.broadcast "private_message_channel", content: @private_message, user: @private_message.user
    end
  end

  private

  def private_message_params
    params.require(:private_message).permit(:content).merge(user_id: current_user.id, private_room_id: params[:private_room_id])
  end
end
