# frozen_string_literal: true

class AddEmailUniqueIndexToUser < ActiveRecord::Migration[6.0]
  def change
    add_index :users, :email, unique: true
  end
end
