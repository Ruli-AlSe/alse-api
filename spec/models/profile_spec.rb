require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Validate Profile model' do
    it 'validate if there is a relation with user' do
      should belong_to(:user)
    end
  end
end
