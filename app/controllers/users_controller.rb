class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    if params[:id] == 'null'
      redirect_to users_path
    else
      @user = User.find(params[:id])
    end
  end
end
