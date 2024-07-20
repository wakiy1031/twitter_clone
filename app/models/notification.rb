class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :subject, polymorphic: true

  scope :includes_desc, -> { includes(:user).order(created_at: :desc) }
end
