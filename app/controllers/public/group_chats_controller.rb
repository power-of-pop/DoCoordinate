class Public::GroupChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @group_chat = @group.group_chats.build(group_chat_params)
    @group_chat.user = current_user

    if @group_chat.save
      redirect_to group_chat_path(@group), notice: '送信されました。'
    else
      @group_chats = @group.group_chats.includes(:user).order(created_at: :asc)
      render "public/groups/chat"
    end
  end



  def destroy
    @group_chat = @group.group_chats.find(params[:id])
    @group_chat.destroy
    redirect_to group_chat_path(@group), notice: '削除されました。'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_chat_params
    params.require(:group_chat).permit(:comment, :chat_image)
  end

end
