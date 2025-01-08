require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'Store validations' do
    subject { build(:store) }

    it 'Validate if name is present' do
      should validate_presence_of(:name)
    end

    it 'validate if exists relation with owner' do
      should have_one(:owner)
    end

    it 'validate if exists relation with employee' do
      should have_many(:employees)
    end
  end
end
