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
class User < ApplicationRecord

  has_many :user_followings, class_name: 'UserFollow', foreign_key: :user_id
  has_many :user_followers, class_name: 'UserFollow', foreign_key: :following_id

  has_many :followings, through: :user_followings, source: :following
  has_many :followers, through: :user_followers, source: :follower
  has_many :tweets

end
