require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validations in post model' do
    it 'should validate if company_id is present' do
      should validate_presence_of(:company_id)
    end

    it 'should validate if name is present' do
      should validate_presence_of(:title)
    end

    it 'should validate if description is present' do
      should validate_presence_of(:content)
    end

    it 'should validate if image_url is present' do
      should validate_presence_of(:image_url)
    end

    it 'should validate post belogs to a company' do
      should belong_to(:company)
    end
  end
end
