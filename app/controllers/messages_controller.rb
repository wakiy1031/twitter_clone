class MessagesController < ApplicationController
  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      redirect_to request.referer
    else
      redirect_to request.referer
      flash.now[:alert] = 'メッセージを確認してください'
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).merge(room_id: params[:room_id].to_i)
  end
end
