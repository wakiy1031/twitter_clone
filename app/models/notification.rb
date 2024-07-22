# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  scope :includes_desc, -> { includes(:user).order(created_at: :desc) }

  delegate :email, to: :user, prefix: true
end
