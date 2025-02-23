class Public::PermitsController < ApplicationController
  before_action :authenticate_user!
  #before_action :ensure_guest_user, only: [:create, :destroy]

  def create
    @group = Group.find(params[:group_id])
    permit = current_user.permits.new(group_id: params[:group_id])
    permit.save
    redirect_to request.referer, notice: "コミュニティへの参加申請をしました。"
  end

  def destroy
    permit = current_user.permits.find_by(group_id: params[:group_id])
    permit.destroy
    redirect_to request.referer, alert: "コミュニティへの参加申請を取り消ししました。"
  end

  private

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to request.referer , notice: "ゲストユーザーの操作は制限されています。"
    end
  end
end
