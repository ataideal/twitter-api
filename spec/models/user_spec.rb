# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:name) }

  end

  describe 'associations' do
    it { should have_many(:tweets) }
    it { should have_many(:user_followings).class_name('UserFollow') }
    it { should have_many(:user_followers).class_name('UserFollow') }
    it { should have_many(:followings).class_name('User') }
    it { should have_many(:followers).class_name('User') }
  end
end
