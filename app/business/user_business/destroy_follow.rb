# frozen_string_literal: true

module UserBusiness
  class DestroyFollow
    include Command

    def initialize(user_id, following_id)
      @user_follow = UserFollow.find_by!(user_id: user_id, following_id: following_id)
      super()
    end

    protected

    def perform
      @user_follow.destroy
      true
    end
  end
end
