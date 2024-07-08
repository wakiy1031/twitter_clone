class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = Post.includes(:user).order(created_at: :desc).page(params[:posts_page]).per(10)
  end
end
