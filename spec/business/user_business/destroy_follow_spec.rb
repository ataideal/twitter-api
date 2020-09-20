# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserBusiness::DestroyFollow do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  let!(:user_follow) { create(:user_follow, follower: user, following: user2)}

  context "when params are correct" do
    subject { described_class.new(user.id, user2.id) }

    it "destroy a user_follow association" do
      expect { subject }.to change { UserFollow.all.count }.from(1).to(0)
    end

    it "result is true" do
      expect(subject.result).to be_truthy
    end

    it "success? is true" do
      expect(subject.success?).to be_truthy
    end

    it "user_follow association not exists" do
      subject
      user_follow = UserFollow.find_by(follower: user, following: user2)
      expect(user_follow).to be_falsey
    end

    it "user has not user2 in following association" do
      subject
      expect(user.followings.count).to eq(0)
      expect(user.followings).to eq([])
    end

    it "user2 has user in followers association" do
      subject
      expect(user2.followers.count).to eq(0)
      expect(user2.followers).to eq([])
    end

    context "when user do not follow user2" do
      before { described_class.new(user.id, user2.id) }

      it "user unfollow act as succeed" do
        subject
        expect(subject.success?).to be_truthy
        expect(subject.result).to be_truthy
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
  end
end