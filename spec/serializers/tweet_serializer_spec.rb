# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TweetSerializer do
  let(:tweet) { create :tweet }

  subject { described_class.new(tweet).as_json }

  describe 'fields' do
    it { is_expected.to include(:id, :content, :created_at, :user) }
  end

  describe 'associtations' do
    it { expect(subject[:user]).to eq(UserSerializer.new(tweet.user).as_json) }
  end
end
