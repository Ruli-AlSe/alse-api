require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'Company validations' do
    subject { build(:company) }

    it 'name is present' do
      should validate_presence_of(:name)
    end

    it 'exists relation with owner' do
      should have_one(:owner)
    end

    it 'exists relation with employee' do
      should have_many(:employees)
    end

    it 'exists relation with posts' do
      should have_many(:posts)
    end

    it 'exists relation with category' do
      should have_many(:categories)
    end
  end
end
