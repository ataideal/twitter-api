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

  has_many :user_follows
  has_many :followings, through: :user_follows
  has_many :followers, through: :user_follows, foreign_key: :following_id
  has_many :tweets

end
