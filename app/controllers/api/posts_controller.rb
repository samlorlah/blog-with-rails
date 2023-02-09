class Api::PostsController < ApplicationController
  load_and_authorize_resource

  def index
    user = User.find(params[:user_id])
    posts = user.posts
    render json: posts
  end
end
