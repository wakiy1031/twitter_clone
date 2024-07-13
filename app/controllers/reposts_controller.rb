# frozen_string_literal: true

class RepostsController < ApplicationController
  def create
    @post_repost = current_user.reposts.build(post_id: params[:post_id])
    @post_repost.save
    redirect_to request.referer
  end

  def destroy
    @post_repost = current_user.reposts.find_by(user_id: current_user.id, post_id: params[:post_id])
    @post_repost.destroy
    redirect_to request.referer
  end
end
