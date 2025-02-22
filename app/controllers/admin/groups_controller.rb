class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    flash[:notice] = "コミュニティは消去されました。"
    redirect_to admin_groups_path
  end

  def chat
    @group = Group.find(params[:id])
    @group_chat = GroupChat.new
    @users = @group.users # グループに所属するユーザーを取得
    @group_chats = @group.group_chats.includes(:user).order(created_at: :asc) # コメントを新しい順に取得
    @user = User.find(params[:id])
  end
  

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

end
