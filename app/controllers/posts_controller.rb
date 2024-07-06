# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = user_signed_in? ? current_user : User.new

    @posts = Post.includes(:user).order(created_at: :desc).page(params[:posts_page]).per(10)
    @followees_posts = Post.includes(:user)
                           .where(user_id: current_user.followee_ids)
                           .order(created_at: :desc)
                           .page(params[:followees_page]).per(10)

    @active_tab = params[:tab] || 'for-you'
  end
end
