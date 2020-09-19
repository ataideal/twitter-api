# frozen_string_literal: true

module TweetBusiness
  class TweetFeed
    include Command

    def initialize(user_id)
      @user = User.find(user_id)
      super()
    end

    protected

    def perform
      user_ids = [@user.id] + UserFollow.where(user_id: @user.id).pluck(:following_id)
      Tweet.where(user_id: user_ids).includes(:user).order(id: :desc)
    end
  end
end
