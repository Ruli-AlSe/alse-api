require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations of the model' do
    subject { build(:post) }

    it 'company_id is present' do
      should validate_presence_of(:company_id)
    end

    it 'title is present' do
      should validate_presence_of(:title)
    end

    it 'contet is present' do
      should validate_presence_of(:content)
    end

    it 'image_url is present' do
      should validate_presence_of(:image_url)
    end

    it 'slug is present' do
      should validate_presence_of(:slug)
    end

    it 'validate if slug is unique' do
      should validate_uniqueness_of(:slug)
    end

    it 'short_description is present' do
      should validate_presence_of(:short_description)
    end

    it 'belongs to a company' do
      should belong_to(:company)
    end

    it 'belongs to a categpory' do
      should belong_to(:category)
    end
  end
end
