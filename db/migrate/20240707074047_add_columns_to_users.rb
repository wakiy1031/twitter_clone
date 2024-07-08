# frozen_string_literal: true

class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.text :introduction
      t.string :place
      t.string :website
    end
  end
end
