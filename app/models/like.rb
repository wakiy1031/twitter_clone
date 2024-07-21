# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
    notification = Notification.create!(subject: self, user: post.user, subject_type: 'Like')
    NotificationMailer.like_notification(notification:).deliver_later
  end
end
