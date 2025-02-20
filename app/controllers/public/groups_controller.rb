class Public::GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :permits]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      GroupUser.create(user_id: current_user.id, group_id: @group.id)
      redirect_to groups_path, method: :post
    else
      render "new"
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render "edit"
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    flash[:notice] = "コミュニティは消去されました。"
    redirect_to groups_path
  end

  def permits
    @group = Group.find(params[:id])
    @permits = @group.permits
  end

  def chat
    @group = Group.find(params[:id])
    @group_chat = GroupChat.new
    @users = @group.users # グループに所属するユーザーを取得
    @group_chats = @group.group_chats.includes(:user).order(created_at: :asc) # コメントを新しい順に取得
  end
  

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :group_image)
  end

  # コミュニティ作成者であるかを確認
  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id = current_user.id
      redirect_to group_path(@group), alert: "作成者のみ編集が可能です。"
    end
  end
end
