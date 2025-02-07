class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
    @post = Post.new
    @users = @users = User.all
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @posts = Post.all
    @users = User.all
    @user = @post.user
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created post successfully."
      redirect_to post_path(@post)
    else
      @posts = Post.all
      @users = User.all
      @user = current_user
      render :index
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
      flash[:notice] = "You have updated post successfully."
      redirect_to post_path(@post)
    else
      @posts = Post.all
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:notice] = "Post was successfully destroyed."
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :post_image)
  end

end
