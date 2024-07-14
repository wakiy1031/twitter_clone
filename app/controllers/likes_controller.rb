# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @post_like = current_user.likes.build(post_id: params[:post_id])
    @post_like.save
    redirect_to request.referer
  end

  def destroy
    @post_like = current_user.likes.find_by(post_id: params[:post_id])
    @post_like.destroy
    redirect_to request.referer
  end
end
