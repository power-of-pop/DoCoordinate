class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  def top
    @user_count = User.count  # ユーザー数
    @post_count = Post.count  # 投稿数
    # @active_user_count = User.where('last_sign_in_at >= ?', 1.week.ago).count  # 1週間以内にログインしたユーザー数
    @recent_users = User.order(created_at: :desc).limit(5)  # 最近登録したユーザー（上位5人）
    @flagged_posts = Post.where(flagged: true).order(reported_at: :desc).limit(5)  # モデレーションが必要な投稿（フラグ付きの投稿）
  end
end
