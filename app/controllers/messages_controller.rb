class MessagesController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    message = Message.new(message_params)
    message.user_id = current_user.id
    if message.save
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end
  
  private 
  def message_params
   params.require(:message).permit(:user_id,:room_id, :content)
  end  

end
