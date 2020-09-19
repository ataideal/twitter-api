# frozen_string_literal: true

class AddUserIndexToUserFollow < ActiveRecord::Migration[6.0]
  def change
    add_index :user_follows, %i[user_id following_id], unique: true
  end
end
