class Public::GroupChatsController < ApplicationController
  def create
    group = Group.find(params[:post_id])
    chat = current_user.group_chats.new(group_chat_params)
    chat.group_id = group.id
    chat.save
    redirect_to post_path(group)*
  end

  def destroy
    GroupChat.find(params[:id]).destroy
    redirect_to post_path(params[:post_id])*
  end

  private

  def group_chat_params
    params.require(:group_chat).permit(:chat)
  end
end
