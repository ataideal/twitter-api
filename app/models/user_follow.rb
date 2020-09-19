# frozen_string_literal: true

# == Schema Information
#
# Table name: user_follows
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  following_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_user_follows_on_following_id              (following_id)
#  index_user_follows_on_user_id                   (user_id)
#  index_user_follows_on_user_id_and_following_id  (user_id,following_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (following_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class UserFollow < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :user_id
  belongs_to :following, class_name: 'User'

  validates :user_id, uniqueness: { scope: :following_id }

  validate :not_following_yourself

  def not_following_yourself
    errors.add(:following_id, :bad_following_id) if user_id == following_id
  end
end
