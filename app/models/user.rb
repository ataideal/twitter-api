# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_many :user_followings, class_name: 'UserFollow', dependent: :destroy

  has_many :user_followers, class_name: 'UserFollow', foreign_key: :following_id, dependent: :destroy

  has_many :followings, through: :user_followings, source: :following
  has_many :followers, through: :user_followers, source: :follower
  has_many :tweets, dependent: :destroy

  validates :email, :name, presence: true
  validates :email, uniqueness: true
end
