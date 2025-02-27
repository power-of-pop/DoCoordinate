class Public::GroupChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group

  def create
    @group = Group.find(params[:group_id])
    @group_chat = current_user.group_chats.new(group_chat_params)
    @group_chat.group_id = @group.id

    if @group_chat.comment.blank?
      redirect_to group_chat_path(@group), alert: 'メッセージを入力してください。'
    elsif @group_chat.save
      redirect_to group_chat_path(@group), notice: '送信されました。'
    else
      redirect_to group_chat_path(@group), alert: 'メッセージの送信に失敗しました。'
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