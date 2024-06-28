# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @user = user_signed_in? ? current_user : User.new
  end
end
