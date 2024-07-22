# frozen_string_literal: true

class Like < ApplicationRecord
  include NotificationCreate

  belongs_to :user
  belongs_to :post

  has_one :notification, as: :subject, dependent: :destroy
end
