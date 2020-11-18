class PrivateMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "private_message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
