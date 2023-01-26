class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where("author_id = #{params[:user_id]}")
  end

  def show
    @post = Post.includes(comments: [:author]).find(params[:id])
  end
end
