class OpenMessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from "open_message_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
