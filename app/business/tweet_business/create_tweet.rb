# frozen_string_literal: true

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
