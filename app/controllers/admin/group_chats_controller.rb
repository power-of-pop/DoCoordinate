class Admin::GroupChatsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group


  def destroy
    GroupChat.find(params[:id]).destroy
    redirect_to admin_group_chat_path(@group), notice: '削除されました。'
  end

  private

  def set_group
    @group = Group.find(params[:group_id]) # グループIDをパラメータから取得
  end

  def group_chat_params
    params.require(:group_chat).permit(:comment, :chat_image)
  end
end
