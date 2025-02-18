class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Post"
      @posts = Post.looks(@word)
    elsif @range == "User"
      @users = User.looks(@word)
    else
      @groups = Group.looks(@word)
    end
  end
end
