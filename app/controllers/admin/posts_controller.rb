class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.all
    @post = Post.new
    @users = User.all
    @user = current_user
  end

  def show
    @post = Post.find_by(id: params[:id])
    if @post.nil?
      redirect_to posts_path
    else
      @posts = Post.all
      @users = User.all
      @user = @post.user
      @post_comment = PostComment.new
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿情報が更新されました。"
      redirect_to post_path(@post)
    else
      @posts = Post.all
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "投稿は消去されました。"
    redirect_to user_path(post.user)
  end

  private
  def authenticate_admin!
    # current_admin が存在し、かつ管理者でない場合にリダイレクト
    redirect_to new_admin_session_path unless current_admin&.admin?
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end

  def correct_user
    @post = Post.find_by(id: params[:id])
    redirect_to posts_path if @post.nil? || @post.user != current_user
  end
  
end
