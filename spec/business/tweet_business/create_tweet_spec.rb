# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TweetBusiness::CreateTweet do
  let!(:user) { create(:user) }
  context 'when tweet params are right' do
    subject { described_class.new(tweet_params) }
    let(:tweet_params) { attributes_for(:tweet, user_id: user.id) }

    it 'creates a tweet' do
      expect { subject }.to change {
        Tweet.all.count
      }.from(0).to(1)
    end

    it '.result is tweet object' do
      expect(subject.result).to be_an Tweet
    end

    it '.result tweet has tweet params' do
      expect(subject.result).to have_attributes(tweet_params)
    end

    it '.result tweet has is the same on database' do
      result = subject.result
      tweet = user.tweets.first
      expect(result.id).to eq(tweet.id)
      expect(result.created_at).to eq(tweet.created_at)
      expect(result.content).to eq(tweet.content)
      expect(result.user_id).to eq(tweet.user_id)
    end

    it '.result is tweet params' do
      expect(subject.result).to have_attributes(tweet_params)
    end

    it '.success? is true' do
      expect(subject.success?).to be_truthy
    end

    it '.errors is nil' do
      expect(subject.errors).to be_falsey
    end
  end

  shared_examples_for 'not creates a tweet' do
    it 'not change tweet count' do
      expect { subject }.to_not(change { Tweet.all.count })
    end

    it 'not succeed' do
      expect(subject.success?).to be_falsey
    end

    it 'have errors' do
      expect(subject.errors).to be_truthy
    end
  end

  context 'when twitter params are wrong' do
    subject { described_class.new(tweet_params) }

    context 'blank content' do
      let(:tweet_params) { { content: '', user_id: 1 } }
      it_behaves_like 'not creates a tweet'
    end

    context 'too short content' do
      let(:tweet_params) { { content: '..', user_id: 1 } }
      it_behaves_like 'not creates a tweet'
    end

    context 'too long content' do
      let(:tweet_params) { { content: Faker::Lorem.characters(number: 280), user_id: 1 } }
      it_behaves_like 'not creates a tweet'
    end

    context 'user not found' do
      let(:tweet_params) { { content: 'tweet', user_id: 1 } }
      it_behaves_like 'not creates a tweet'
    end

    context 'blank params' do
      let(:tweet_params) { {} }
      it_behaves_like 'not creates a tweet'
    end
  end
end
