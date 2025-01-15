require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Validation of the model' do
    subject { build(:category) }

    it 'title is present' do
      should validate_presence_of(:title)
    end

    it 'description is present' do
      should validate_presence_of(:description)
    end

    it 'slug is present' do
      should validate_presence_of(:slug)
    end

    it 'validate if slug is unique' do
      should validate_uniqueness_of(:slug).scoped_to(:company_id)
    end

    it 'has many posts relationship' do
      should have_many(:posts)
    end

    it 'belongs to company relationship' do
      should belong_to(:company)
    end
  end
end
