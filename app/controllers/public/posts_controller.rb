class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  #before_action :ensure_guest_user, only: [:create, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def index
    @posts = Post.all.order(created_at: :desc).page(params[:page])
    @post = Post.new
    @users = User.all
    @user = current_user
  end

  def show
    @post = Post.find_by(id: params[:id])
    @posts = Post.all
    @users = User.all
    @user = @post.user
    @post_comment = PostComment.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    # 画像がある場合のみvision apiを呼び出す
    if post_params[:post_image].present?
      tags = Vision.get_image_data(post_params[:post_image])
    else
      tags = []
    end

    if @post.save
      tags.each do |tag|
        @post.tags.create(name: tag)
      end
      flash[:notice] = "正常に投稿されました。"
      redirect_to post_path(@post)
    else
      @posts = Post.all
      @users = User.all
      @user = current_user
      render :new
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
  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end

  def ensure_guest_user
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to new_post_path , notice: "ゲストユーザーの操作は制限されています。"
    end
  end
end
