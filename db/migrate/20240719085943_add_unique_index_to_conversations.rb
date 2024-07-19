class AddUniqueIndexToConversations < ActiveRecord::Migration[7.0]
  def change
    add_index :conversations, [:user_id, :room_id], unique: true
  end
end
