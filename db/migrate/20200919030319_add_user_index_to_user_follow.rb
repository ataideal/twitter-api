class AddUserIndexToUserFollow < ActiveRecord::Migration[6.0]
  def change
    add_index :user_follows, [:user_id, :following_id], unique: true
  end
end
