# frozen_string_literal: true

class Repost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, user: self.post.user, subject_type: 'Repost')
  end
end
