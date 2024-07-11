# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_posts
  def index; end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to request.referer
    else
      set_posts
      flash.now[:alert] = '140字以内の投稿にしてください。'
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_posts
    @user = user_signed_in? ? current_user : User.new

    @post = Post.new
    @posts = Post.includes_desc.page(params[:posts_page]).per(10)
    @followees_posts = Post.includes_desc
                           .where(user_id: current_user.followee_ids)
                           .page(params[:followees_page]).per(10)

    @active_tab = params[:tab] || 'for-you'
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
