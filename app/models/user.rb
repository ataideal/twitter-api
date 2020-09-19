# frozen_string_literal: true

class User < ApplicationRecord

  has_many :user_follows
  has_many :followings, through: :user_follows
  has_many :followers, through: :user_follows, foreign_key: :following_id
  has_many :tweets

end
