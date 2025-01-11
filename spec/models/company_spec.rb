require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'Company validations' do
    subject { build(:company) }

    it 'Validate if name is present' do
      should validate_presence_of(:name)
    end

    it 'validate if exists relation with owner' do
      should have_one(:owner)
    end

    it 'validate if exists relation with employee' do
      should have_many(:employees)
    end

    it 'validate if exists relation with products' do
      should have_many(:products)
    end
  end
end
