class CommentsController < ApplicationController
  before_action :authenticate_user!

  # チャネルを利用してコメントの送信を行う
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      ActionCable.server.broadcast "comment_channel", content: @comment, user: current_user
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
