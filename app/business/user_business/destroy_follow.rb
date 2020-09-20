# frozen_string_literal: true

module UserBusiness
  class DestroyFollow
    include Command

    def initialize(user_id, following_id)
      @user = User.find(user_id)
      @following = User.find(following_id)
      @user_follow = UserFollow.find_by(follower: @user, following: @following)
      super()
    end

    protected

    def perform
      return true if @user_follow.nil?
      @user_follow.destroy
      true
    end
  end
end
