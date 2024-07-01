# frozen_string_literal: true

class UpdateUsersForOmniauth < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :phone, true
    change_column_null :users, :birthdate, true
  end
end
