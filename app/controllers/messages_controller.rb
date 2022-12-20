class MessagesController < ApplicationController
  before_action :follow_check,only:[:message]
  def message
    @message=Message.new
    @send_messages=Message.where(send_user_id:current_user.id,receive_user_id:params[:id])
    @receive_messages=Message.where(send_user_id:params[:id],receive_user_id:current_user.id)
  end
  def create
    @message=Message.new(message_params)
    @message.send_user_id=current_user.id
    @message.save!
    @send_messages=Message.where(send_user_id:current_user.id,receive_user_id:message_params[:receive_user_id])
    @receive_messages=Message.where(send_user_id:message_params[:receive_user_id],receive_user_id:current_user.id)
  end

  private
  def message_params
    params.require(:message).permit(:receive_user_id,:chat)
  end

  def follow_check
      ##自分自身とのDMを防ぐ
      if params[:id]==current_user.id
        redirect_back fallback_location: root_path
      else
      ## 相互にフォローしているかの確認。
        check1=Relationship.exists?(followed_id:params[:id],follower_id:current_user.id)
        check2=Relationship.exists?(follower_id:params[:id],followed_id:current_user.id)
        if !check1 || !check2
          redirect_back fallback_location: root_path
        end
      end
  end
end
