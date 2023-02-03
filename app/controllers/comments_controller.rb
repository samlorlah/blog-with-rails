class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to user_post_path(current_user, @comment.post)
    else
      render :create
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if @comment.destroy
      @comment.update_comment_counter_when_comment_deleted
      redirect_to user_post_path(@post.author_id, @post.id)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
