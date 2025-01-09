require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations in product model' do
    it 'should validate if store_id is present' do
      should validate_presence_of(:store_id)
    end

    it 'should validate if name is present' do
      should validate_presence_of(:name)
    end

    it 'should validate if description is present' do
      should validate_presence_of(:description)
    end

    it 'should validate if price is present' do
      should validate_presence_of(:price)
    end

    it 'should validate product belogs to a store' do
      should belong_to(:store)
    end
  end
end
