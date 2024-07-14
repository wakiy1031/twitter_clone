# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts.includes_desc.page(params[:posts_page]).per(10)
    @like_posts = @user.like_posts.includes_desc.page(params[:like_page]).per(10)
    @repost_posts = @user.repost_posts.includes_desc.page(params[:repost_page]).per(10)
    @comment_posts = @user.comment_posts.includes_desc.page(params[:comment_page]).per(10)

    @active_tab = params[:tab] || 'post'
  end

  def edit
    @post = Post.new
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: 'プロフィールが更新されました。'
    else
      render :edit
    end
  end

  def follow_list
    @active_tab = params[:tab] || 'followees'
    @followees = @user.followees.page(params[:followees_page]).per(10)
    @followers = @user.followers.page(params[:followers_page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(%i[avatar_image header_image name introduction place website])
  end
end
