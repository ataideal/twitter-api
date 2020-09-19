class CreateUserFollows < ActiveRecord::Migration[6.0]
  def change
    create_table :user_follows do |t|
      t.references :user, null: false, foreign_key: true, index: true
      t.references :following, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
