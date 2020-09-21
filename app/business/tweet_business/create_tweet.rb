# frozen_string_literal: true

# This class is responsible for all business logic to create a tweet.
# tweet_params e.g.
# {
#   "content": "tweet",
#   "user_id": 1
# }
#
module TweetBusiness
  class CreateTweet
    include Command

    def initialize(tweet_params)
      @tweet_params = tweet_params
      super()
    end

    protected

    def perform
      tweet = Tweet.new(@tweet_params)
      @errors = tweet.errors unless tweet.save
      tweet
    end
  end
end
