# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BaseController

      # Follow a user
      def follow
        command = UserBusiness::CreateFollow.new(params[:id], params[:following_id])
        if command.success?
          head :created
        else
          render_errors(errors: command.errors, message: command.errors.full_messages.to_sentence, status: 422)
        end
      end

      # Unfollow a user
      def unfollow
        command = UserBusiness::DestroyFollow.new(params[:id], params[:following_id])
        head :no_content if command.success?
      end
    end
  end
end
