class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    @like = Like.new
  end

  def create
    @like = current_user.likes.new
    @like.post_id = params[:post_id]
    if @like.save
      redirect_to user_post_path(current_user, @like.post)
    else
      render :create
    end
  end
end
