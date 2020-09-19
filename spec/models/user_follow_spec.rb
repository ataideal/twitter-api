# == Schema Information
#
# Table name: user_follows
#
#  id           :bigint           not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  following_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_user_follows_on_following_id  (following_id)
#  index_user_follows_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (following_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserFollow, type: :model do
  describe 'validations' do
    it { should belong_to(:user)  }
    it { should belong_to(:following)  }
  end

  describe 'associations' do
    it { should belong_to(:user)  }
    it { should belong_to(:following)  }
  end
end
