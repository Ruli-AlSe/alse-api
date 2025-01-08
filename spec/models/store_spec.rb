require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'Store validations' do
    subject { build(:store) }

    it 'Validate if name is present' do
      should validate_presence_of(:name)
    end
  end
end
