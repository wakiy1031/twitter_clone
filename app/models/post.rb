# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 140 }

  has_many :likes, dependent: :destroy
  has_many :reposts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :like_users, through: :likes, source: :user
  has_many :repost_users, through: :reposts, source: :user
  has_many :comment_users, through: :comments, source: :user

  scope :includes_desc, -> { includes(:user).order(created_at: :desc) }

  def reposted_by?(user)
    repost_users.include?(user)
  end

  def liked_by?(user)
    like_users.include?(user)
  end
end
