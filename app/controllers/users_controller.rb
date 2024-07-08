class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.includes(:user).order(created_at: :desc).page(params[:posts_page]).per(10)
    @like_posts = @user.like_posts.includes(:user).order(created_at: :desc).page(params[:like_page]).per(10)
    @repost_posts = @user.repost_posts.includes(:user).order(created_at: :desc).page(params[:repost_page]).per(10)
    @comment_posts = @user.comment_posts.includes(:user).order(created_at: :desc).page(params[:comment_page]).per(10)

    @active_tab = params[:tab] || 'post'
  end
end
