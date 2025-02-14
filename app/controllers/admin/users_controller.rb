class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  # 退会機能
  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
    flash[:notice] = '退会しました。'
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :profile, :profile_image, :introduction)
  end

end
