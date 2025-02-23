class Public::PostCommentsController < ApplicationController
  #before_action :ensure_guest_user, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      redirect_to post_path(@post), notice: '送信されました。'
    else
      @posts = Post.all
      @users = User.all
      @user = @post.user
      render "public/posts/show"
    end

  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to post_path(params[:post_id]), notice: '削除されました。'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

  def ensure_guest_user
    @post = Post.find(params[:post_id])
    @user = current_user
    if @user.email == "guest@example.com"
      redirect_to post_path(@post) , notice: "ゲストユーザーの操作は制限されています。"
    end
  end
end
