# frozen_string_literal: true

# This class is responsible for create a follow relationship between users.

module UserBusiness
  class CreateFollow
    include Command

    def initialize(user_id, following_id)
      @user = User.find(user_id)
      @following = User.find(following_id)
      super()
    end

    protected

    def perform
      user_follow = UserFollow.find_by(follower: @user, following: @following)
      return user_follow if user_follow.present?
      user_follow = @user.user_followings.build(following: @following)
      @errors = user_follow.errors unless user_follow.save
      user_follow
    end
  end
end
