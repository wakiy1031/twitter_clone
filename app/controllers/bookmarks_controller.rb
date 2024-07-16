# frozen_string_literal: true

class BookmarksController < ApplicationController
  before_action :set_user

  def index
    @bookmark_posts = @user.bookmark_posts.includes_desc.page(params[:bookmark_page]).per(10)
  end

  def create
    @post_bookmark = current_user.bookmarks.build(post_id: params[:post_id])
    @post_bookmark.save
    redirect_to request.referer
  end

  def destroy
    @post_bookmark = current_user.bookmarks.find_by(post_id: params[:post_id])
    @post_bookmark.destroy
    redirect_to request.referer
  end
end
