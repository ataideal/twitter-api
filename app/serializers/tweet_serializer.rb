# frozen_string_literal: true

class TweetSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at

  belongs_to :user
end
