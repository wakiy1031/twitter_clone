# frozen_string_literal: true

class FollowsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @followees = @user.followees.page(params[:followees_page]).per(10)
    @followers = @user.followers.page(params[:followers_page]).per(10)
    @active_tab = params[:tab] || 'followees'
  end

  def create
    @follow = current_user.active_follows.create(followee_id: params[:user_id])
    redirect_to request.referer
  end

  def destroy
    @follow = current_user.active_follows.find_by(followee_id: params[:user_id])
    @follow.destroy
    redirect_to request.referer
  end
end
