class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes([:author]).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    respond_to do |format|
      format.html do
        if @post.save
          redirect_to "/users/#{@post.author.id}/posts/#{@post.id}"
        else
          render :new
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    if @post.destroy
      @post.update_post_counter_when_post_deleted
      redirect_to user_posts_path(current_user.id)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :likes_counter, :comments_counter)
  end
end
