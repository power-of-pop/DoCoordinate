class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Post"
      @posts = Post.looks(params[:search], params[:word])
    else
      @users = User.looks(params[:search], params[:word])
    end
  end
end
