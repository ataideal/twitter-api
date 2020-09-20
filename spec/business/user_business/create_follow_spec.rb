# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBusiness::CreateFollow do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }

  context "when params are correct" do
    subject { described_class.new(user.id, user2.id) }

    it "create a user_follow association" do
      expect { subject }.to change { UserFollow.all.count }.from(0).to(1)
    end

    it "result is a user_follow" do
      expect(subject.result).to be_an UserFollow
    end

    it "user_follow association has user_id and following_id as expect" do
      user_follow = subject.result
      expect(user_follow.follower).to eq(user)
      expect(user_follow.following).to eq(user2)
    end

    it "user has user2 in following association" do
      subject
      expect(user.followings.count).to eq(1)
      expect(user.followings).to eq([user2])
    end

    it "user2 has user in followers association" do
      subject
      expect(user2.followers.count).to eq(1)
      expect(user2.followers).to eq([user])
    end

    context "when user already follow user2" do
      before { described_class.new(user.id, user2.id) }

      it "user follow act as succeed" do
        subject
        expect(subject.success?).to be_truthy
        expect(subject.result).to be_an UserFollow
        expect(subject.errors).to be_falsey
      end
    end
  end

  context "when params are wrong" do

    context "when following id not exists" do
      subject { described_class.new(user.id, 0) }

      it "not found user" do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "when user id not exists" do
      subject { described_class.new(0, user2.id) }

      it "not found user" do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "when user id and following id not exists" do
      subject { described_class.new(0, 0) }

      it "not found user" do
        expect { subject }.to raise_exception(ActiveRecord::RecordNotFound)
      end
    end

    context "when user try to follow himself" do
      subject { described_class.new(user.id, user.id) }

      it "create a user_follow association" do
        expect { subject }.to_not(change{ UserFollow.all.count })
      end

      it "do not create user follow" do
        subject
        expect(subject.success?).to be_falsey
        expect(subject.result).to be_an UserFollow
        expect(subject.errors).to be_truthy
      end

      it "return message error" do
        expect(subject.errors[:following_id]).to eq(["You can't follow yourself"])
      end
    end

  end
end