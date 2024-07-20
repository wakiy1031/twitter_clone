class NotificationsController < ApplicationController
  before_action :set_user
  def index
    @notifications = @user.notifications.includes_desc.page(params[:page]).per(10)
  end
end
