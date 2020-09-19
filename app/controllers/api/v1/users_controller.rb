module Api
  module V1
    class UsersController < Api::V1::BaseController
      def follow
        command = UserBusiness::CreateFollow.new(params[:id], params[:following_id])
        if command.sucess?
          head :created
        else
          render_errors(errors: command.errors, message: command.errors.full_messages.to_sentence, status: 422)
        end
      end
    end
  end
end

