class Public::GroupChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @group_chat = @group.group_chats.build(group_chat_params)
    @group_chat.user = current_user
    @group_chat.save
    redirect_to group_chat_path(@group), notice: 'メッセージが送信されました。'
  end



  def destroy
    @group_chat = @group.group_chats.find(params[:id])
    @group_chat.destroy
    redirect_to group_chat_path(@group), notice: 'メッセージが削除されました。'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_chat_params
    params.require(:group_chat).permit(:comment, :chat_image)
  end

end
