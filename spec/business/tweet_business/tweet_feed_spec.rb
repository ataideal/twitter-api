# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TweetBusiness::TweetFeed do
  let!(:user) { create(:user) }
  let(:user_followings) { create_list(:user_follow, 2, follower: user) }

  before do
    create_list(:tweet, 5, user: user)
    create_list(:tweet, 5, user: user_followings.first.following)
    create_list(:tweet, 5, user: user_followings.last.following)
  end

  context 'tweet feed from user' do
    subject { described_class.new(user.id) }

    it '.result is an Array' do
      expect(subject.result).to be_an ActiveRecord::Relation
    end

    it 'list all tweets from himself and his followings' do
      expect(subject.result.size).to eq(15)
    end

    it 'list all tweets in order desc' do
      expect(
        subject.result.each_cons(2).all? { |a, b| (a <=> b) >= 0 }
      ).to be_truthy
    end

    context 'after unfollow a user' do
      before { user_followings.first.destroy! }
      it 'dont list user tweets after' do
        expect(subject.result.size).to eq(10)
      end
    end

    context 'after unfollow all users' do
      before { user.user_followings.destroy_all }
      it 'dont list users tweets after' do
        expect(subject.result.size).to eq(user.tweets.count)
      end
    end

    context 'after follow a new user' do
      let(:new_user) { create(:user) }
      it 'dont list user tweets after' do
        create_list(:tweet, 10, user: new_user)
        expect { create(:user_follow, follower: user, following: new_user) }.to change {
          described_class.new(user.id).result.size
        }.by(10)
      end
    end
  end

  context 'when user not found' do
    subject { described_class.new(0) }

    it 'raise record not found' do
      expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
