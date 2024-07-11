# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_many_attached :images
  scope :includes_desc, -> { includes(:user).order(created_at: :desc) }

  validates :content, presence: true, length: { maximum: 140 }
end
