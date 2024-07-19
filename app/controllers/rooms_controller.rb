# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :set_user
  before_action :set_room_data, only: %i[index show]

  def index; end

  def show
    room = current_user.rooms.find(params[:id])
    @messages = room.messages.includes(:user)
  end

  def create
    other_user_id = params[:user_id]

    existing_room = Room.search_for_existing_room(user_id: current_user.id, other_id: other_user_id)

    if existing_room
      room = existing_room
    else
      room = Room.create
      room.conversations.create(user_id: current_user.id)
      room.conversations.create(user_id: other_user_id)
    end

    redirect_to "/rooms/#{room.id}"
  end

  private

  def set_room_data
    @room_data = current_user.rooms.includes(:conversations, :users).map do |room|
      {
        room:,
        user: room.users.find { |user| user.id != current_user.id }
      }
    end
    @selected_room = @room_data.find { |room_data| params[:id].to_i == room_data[:room].id }
  end
end
