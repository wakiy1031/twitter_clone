# frozen_string_literal: true

module NotificationCreate
  extend ActiveSupport::Concern

  included do
    after_create_commit :create_notifications
  end

  private

  def create_notifications
    notification = Notification.create!(subject: self, user: post.user, subject_type: self.class.name)
    NotificationMailer.notification_email(notification:).deliver_later
  end
end
