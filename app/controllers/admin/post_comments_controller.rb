class Admin::PostCommentsController < ApplicationController

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id]), notice: '削除されました。'
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
