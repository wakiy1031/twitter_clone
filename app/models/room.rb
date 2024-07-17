class Room < ApplicationRecord
  has_many :conversations, dependent: :destroy
  has_many :messages, dependent: :destroy

  has_many :users, through: :conversations
end
