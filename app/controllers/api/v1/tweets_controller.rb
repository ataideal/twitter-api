# frozen_string_literal: true

module Api
  module V1
    class TweetsController < Api::V1::BaseController

      # List tweets from user's feed
      def index
        command = TweetBusiness::TweetFeed.new(params[:user_id])
        render json: command.result, status: :ok if command.success?
      end


      # Create a user tweet
      def create
        command = TweetBusiness::CreateTweet.new(tweet_params)
        if command.success?
          render json: command.result, status: :created
        else
          render_errors(errors: command.errors, message: command.errors.full_messages.to_sentence, status: 422)
        end
      end

      private

      def tweet_params
        params.require(:tweet).permit(:content, :user_id)
      end
    end
  end
end
