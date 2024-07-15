# frozen_string_literal: true

class FollowsController < ApplicationController
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
