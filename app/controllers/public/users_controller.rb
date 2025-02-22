class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @posts = @user.posts
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "ユーザー情報が更新されました。"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  # 退会機能
  def destroy
    @user.destroy
    flash[:notice] = '退会しました。'
    redirect_to new_user_registration_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :profile_image, :introduction)
  end

  private


  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def set_user
     @user = User.find(params[:id])
  end
end
