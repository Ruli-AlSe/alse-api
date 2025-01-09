require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'Validate Token model' do
    subject { build(:token) }

    it 'validate if token is present' do
      should validate_presence_of(:token)
    end

    it 'validate if user_id is present' do
      should validate_presence_of(:user_id)
    end

    it 'validate if expires_at is present' do
      should validate_presence_of(:expires_at)
    end

    it 'validate if there is a relation with user' do
      should belong_to(:user)
    end
  end
end
