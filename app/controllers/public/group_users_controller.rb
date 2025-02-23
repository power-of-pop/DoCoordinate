class Public::GroupUsersController < ApplicationController
  before_action :authenticate_user!

  # 参加申請
  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_user = GroupUser.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy #参加希望者リストから削除する
    redirect_to request.referer
  end

  # 申請取消
  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
    group_user.destroy
    redirect_to request.referer
  end

  def reject
    @permit = Permit.find(params[:permit_id])
    @permit.destroy
    redirect_to request.referer
  end

end
