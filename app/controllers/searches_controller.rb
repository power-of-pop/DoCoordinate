class SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Post"
      @posts = Post.looks(@word)
    else
      @users = User.looks(@word)
    end
  end
end
