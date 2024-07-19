# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :users, through: :conversations

  def self.search_for_existing_room(user_id:, other_id:)
    Room.joins(:conversations)
        .where(conversations: { user_id: [user_id, other_id] })
        .group(:id)
        .having('COUNT(DISTINCT conversations.user_id) = 2')
        .first
  end
end
