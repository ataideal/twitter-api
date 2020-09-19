# frozen_string_literal: true

# == Schema Information
#
# Table name: tweets
#
#  id         :bigint           not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_tweets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should_not allow_value('   ').for(:content) }
    it { should allow_value('...').for(:content) }
    it { should validate_length_of(:content).is_at_least(3).is_at_most(280) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
