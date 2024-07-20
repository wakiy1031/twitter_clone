# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many_attached :images
  has_one :notification, as: :subject, dependent: :destroy
  scope :includes_desc, -> { includes(:user).order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 140 }

  after_create_commit :create_notifications

  private

  def create_notifications
    Notification.create(subject: self, user: self.post.user, subject_type: 'Comment')
  end
end
