# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer do
  let(:user) { create :user }

  subject { described_class.new(user).as_json }

  describe 'fields' do
    it { is_expected.to include(:id, :name, :email)}
  end
end
